require('@nomiclabs/hardhat-ethers');
require('dotenv/config');

const RINKEBY_URL = process.env.RINKEBY_URL;
const RINKEBY_PRIVATE_KEY = process.env.RINKEBY_PRIVATE_KEY;

module.exports = {
    solidity: "0.8.4",
    defaultNetwork: "rinkeby",
    networks: {
        hardhat:{},
        rinkeby:{
        url: RINKEBY_URL,
        accounts: [`0x${RINKEBY_PRIVATE_KEY}`]
        }
    }
};
