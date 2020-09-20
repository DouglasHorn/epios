const fs = require("fs");
const path = require("path");
const ScatterJS = require("@scatterjs/core").default;
const ScatterEOS = require("@scatterjs/eosjs2").default;
const { JsonRpc, Api, Serialize } = require("eosjs");
const { TextEncoder, TextDecoder } = require(`util`);
const dotenv = require("dotenv");

const { spawn } = require('child_process');

require("isomorphic-fetch");

ScatterJS.plugins(new ScatterEOS());

const stages = {
  "local": {
    env: "local",
    name: "LOCAL"
  },
  "testnet": {
    env: "testnet",
    name: "TESTNET"
  },
  "mainnet": {
    env: "mainnet",
    name: "MAINNET"
  }
}

const stage = stages[process.argv[2]];

if (!stage) {
  console.log("Invalid stage! Set one of ", Object.keys(stages));
  process.exit(1);
}

const contract = {
  pathToFiles: path.resolve(__dirname, "../src/epios"),
  wasm: "epios.wasm",
  abi: "epios.abi",
  name: "Epios"
};

const stageEnv = dotenv.config({ path: path.resolve(__dirname, `.env.${stage.env}`) }).parsed;
const baseEnv = dotenv.config({ path: path.resolve(__dirname, ".env.common") }).parsed;
const env = { ...stageEnv, ...baseEnv };

async function loadContract(api, contract) {
  const wasm = fs
    .readFileSync(path.join(contract.pathToFiles, contract.wasm))
    .toString(`hex`);

  const buffer = new Serialize.SerialBuffer({
    textEncoder: api.textEncoder,
    textDecoder: api.textDecoder,
  });
  let abi = JSON.parse(
    fs.readFileSync(path.join(contract.pathToFiles, contract.abi), 'utf8')
  );
  const abiDefinition = api.abiTypes.get(`abi_def`);
  abi = abiDefinition.fields.reduce(
    (acc, { name: fieldName }) =>
      Object.assign(acc, { [fieldName]: acc[fieldName] || [] }),
    abi
  );
  abiDefinition.serialize(buffer, abi);

  return {
    abi: Buffer.from(buffer.asUint8Array()).toString(`hex`),
    wasm
  };
}

async function deploy(stage, env) {
  const network = ScatterJS.Network.fromJson({
    blockchain: env.BLOCKCHAIN_NAME,
    protocol: env.EOS_PROTOCOL,
    host: env.EOS_HOST,
    port: env.EOS_PORT,
    chainId: env.EOS_CHAIN_ID
  });
  const rpc = new JsonRpc(network.fullhost());

  const api = new Api({
    rpc,
    textDecoder: new TextDecoder(),
    textEncoder: new TextEncoder(),
  });
  if (!await ScatterJS.connect(env.SCATTER_APP_NAME, { network })) {
    throw "Scatter not installed";
  }
  const eos = ScatterJS.eos(network, Api, api);
  await ScatterJS.logout();
  await ScatterJS.login();
  const account = ScatterJS.account(env.BLOCKCHAIN_NAME);
  if (!contract) {
    throw "Invalid account";
  }

  console.log(`Deploying ${contract.name} on stage ${stage.name}`);
  const { wasm, abi } = await loadContract(api, contract);

  const deployActions = [
    {
      account: "eosio",
      name: "setcode",
      authorization: [
        {
          actor: account.name,
          permission: env.DEFAULT_EOS_PERMISSION
        }
      ],
      data: {
        account: account.name,
        vmtype: 0,
        vmversion: 0,
        code: wasm
      }
    },
    {
      account: "eosio",
      name: "setabi",
      authorization: [
        {
          actor: account.name,
          permission: env.DEFAULT_EOS_PERMISSION
        }
      ],
      data: {
        account: account.name,
        abi,
      }
    },
  ]
  await eos.transact(
    {
      actions: deployActions,
    },
    {
      blocksBehind: 3,
      expireSeconds: 90
    }
  );
}

deploy(stage, env).then(() => {
  console.log(`Successfully deployed on stage ${stage.name}`);
  process.exit(0);
}).catch((err) => {
  console.log("Failed to deploy cause", err);
  process.exit(1);
})