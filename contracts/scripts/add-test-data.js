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

const stageEnv = dotenv.config({ path: path.resolve(__dirname, `.env.${stage.env}`) }).parsed;
const baseEnv = dotenv.config({ path: path.resolve(__dirname, ".env.common") }).parsed;
const env = { ...stageEnv, ...baseEnv };

async function addTestData(stage, env) {
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
  const mainAccountName = "main.epios";

  // if (account.name != mainAccountName) {
  //   throw "Invalid account";
  // }

  // console.log('Adding country');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'crcountry',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "country_name": "United States of America"
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

  // console.log('Adding project manager');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'crmanager',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "manager_name": "main.epios"
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

  // console.log('Adding country manager');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'crcntmanager',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "country_manager_name": "main.epios",
  //           "manager_name": "main.epios",
  //           "country_id": 1
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

  // console.log('Adding test lab');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'apprlab',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "country_manager_name": "main.epios", 
  //           "name": "Test Lab 1", 
  //           "address": "123 Main St, New York, NY 11111 USA", 
  //           "phone": "12223334444", 
  //           "email": "lab@testlab.com",  
  //           "country_id": 1
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

  // console.log('Adding kit seller');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'apprseller',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "country_manager_name": "main.epios", 
  //           "name": "Test Kit Seller", 
  //           "address": "235 Main St, New York, NY 11111 USA", 
  //           "url": "test1@kitseller.com", 
  //           "flag": 1,  
  //           "country_id": 1
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

  // console.log('Adding test coupons');
  /* Test coupon codes:
  LTFWGPY2ROZNM
  6KVD6DK3TWYRM
  HYBDURMTLZUUW
  O4ORL4DKLIQ5W
  KXSYLCP4PCWLE
  ELUHUU5ARGUN4
  O6XTATKA53NHO
  5WEWUGVMWJXLM
  5EFJF7G5PENOG
  EYPKFAXNG7GZO
  */

  await eos.transact(
    {
      actions: [
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "2f3d0d3c0062a87d4ad2fa428d540922028fcd533df1a9f3ef69ca92a098284a", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "8f5a3e0f987f86d44b6682272bd27c1a761d8c55dc322524cbd1e8a538f6df97", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "1188141c2448f11883961af5873686235309183a79698d4535ecf27936d743b6", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "4e7b59fd8d3508c0165e88353c51b3b4803f9659b2e07a8344d7e573ea2aca5d", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "e78b0f286e84ab0412f9c095cbd628071732ee41ed0d44eacd9a0f498fcb4d0f", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "fffd0aa03df1b716357730527aeade7858df91ee7c8ca9bdf659bbd6e9763111", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "8487d74a402a19c41197a9028cb11b2f09ce65acfca0bceaad943d392da19bee", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "8c7912c1a872caeefa7522b580ed250b3bdb08203d3fd0e691d45187fe048ec9", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "79bfbd31ce0c4002100c382c5e7d704a5ced620fff4d4d60d31d9afdaca1e0cf", 
            "country_id": 840
          }
        },
        {
          account: mainAccountName,
          name: 'crcoupon',
          authorization: [
            {
              actor: account.name,
              permission: env.DEFAULT_EOS_PERMISSION
            }
          ],
          data: {
            "country_manager_name": account.name, 
            "secret_key_hash": "77a9fcd79f5fff474fed77993a59362bf2b3b612c57335809c19bd3e31ccf504", 
            "country_id": 840
          }
        }
      ]
    },
    {
      blocksBehind: 3,
      expireSeconds: 90
    }
  );

  // console.log('Post test result');
  // await eos.transact(
  //   {
  //     actions: [
  //       {
  //         account: mainAccountName,
  //         name: 'posttestres',
  //         authorization: [
  //           {
  //             actor: mainAccountName,
  //             permission: env.DEFAULT_EOS_PERMISSION
  //           }
  //         ],
  //         data: {
  //           "country_manager_name": "main.epios", 
  //           "coupon_id": 0, 
  //           "secret_key_hash": "$\\xd9hu\\x98h\\x16?", 
  //           "country_id": 1, 
  //           "test_type": "value test_type"
  //           "report": "value report"
  //           "test_date": 1563027637, 
  //           "result": "POSITIVE", 
  //           "lab_id": 1
  //         }
  //       }
  //     ]
  //   },
  //   {
  //     blocksBehind: 3,
  //     expireSeconds: 90
  //   }
  // );

//   console.log('delete couponsq');
//   await eos.transact(
//     {
//       actions: [
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 0
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 1
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 2
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 3
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 4
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 5
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 6
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 7
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 8
//           }
//         },
//         {
//           account: mainAccountName,
//           name: 'delcoupon',
//           authorization: [
//             {
//               actor: mainAccountName,
//               permission: env.DEFAULT_EOS_PERMISSION
//             }
//           ],
//           data: {
//             "country_manager_name": "main.epios",
//             "id": 9
//           }
//         }
//       ]
//     },
//     {
//       blocksBehind: 3,
//       expireSeconds: 90
//     }
//   );
}

addTestData(stage, env).then(() => {
  console.log(`Successfully added test data on stage ${stage.name}`);
  process.exit(0);
}).catch((err) => {
  console.log("Failed to deploy cause", err);
  process.exit(1);
})