# LucID Contracts

This directory contains the interface specification ([`LucID_Interface.sol`](./LucID_Interface.sol)) and reference implementation ([`LucID.sol`](./LucID.sol)) of the LucID protocol in Solidity.

The `LucID.sol` contract has been deployed to the Ropsten Testnet at: [`0x3F152368750eCe79bA7758a4A81361b82Ba12b95`](https://ropsten.etherscan.io/address/0x3f152368750ece79ba7758a4a81361b82ba12b95) for general-purpose testing.

Another `LucID.sol` contract has also been deployed to the Ropsten Testnet at: [`0x801D1cEe4315042D2cBC5d7AD312594536401BbF`](https://ropsten.etherscan.io/address/0x801D1cEe4315042D2cBC5d7AD312594536401BbF) for our pitching demonstration at HKBCOL finals 2021.

## ABI

The LucID contract ABI is:

```json
[{"inputs":[{"internalType":"string","name":"name_","type":"string"},{"internalType":"string","name":"docType_","type":"string"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_owner","type":"address"},{"indexed":true,"internalType":"bytes32","name":"_old","type":"bytes32"},{"indexed":true,"internalType":"bytes32","name":"_new","type":"bytes32"}],"name":"iNFTExchange","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_to","type":"address"},{"indexed":true,"internalType":"bytes32","name":"_infoHash","type":"bytes32"}],"name":"iNFTMinted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"_from","type":"address"},{"indexed":true,"internalType":"address","name":"_to","type":"address"},{"indexed":true,"internalType":"bytes32","name":"_infoHash","type":"bytes32"}],"name":"iNFTTransfer","type":"event"},{"inputs":[{"internalType":"address","name":"_owner","type":"address"},{"internalType":"bytes32","name":"_old","type":"bytes32"},{"internalType":"bytes32","name":"_new","type":"bytes32"}],"name":"createExchange","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"docType","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_to","type":"address"},{"internalType":"bytes32","name":"_infoHash","type":"bytes32"}],"name":"mintINFT","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"_infoHash","type":"bytes32"}],"name":"ownerOf","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"_exchangeID","type":"bytes32"}],"name":"sealExchange","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"_exchangeID","type":"bytes32"}],"name":"signExchange","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceID","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"pure","type":"function"},{"inputs":[{"internalType":"address","name":"_to","type":"address"},{"internalType":"bytes32","name":"_infoHash","type":"bytes32"}],"name":"transfer","outputs":[],"stateMutability":"payable","type":"function"}]
```

or, with better indentation:

```json
[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "name_",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "docType_",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "bytes32",
				"name": "_old",
				"type": "bytes32"
			},
			{
				"indexed": true,
				"internalType": "bytes32",
				"name": "_new",
				"type": "bytes32"
			}
		],
		"name": "iNFTExchange",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "bytes32",
				"name": "_infoHash",
				"type": "bytes32"
			}
		],
		"name": "iNFTMinted",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "_from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "bytes32",
				"name": "_infoHash",
				"type": "bytes32"
			}
		],
		"name": "iNFTTransfer",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "_old",
				"type": "bytes32"
			},
			{
				"internalType": "bytes32",
				"name": "_new",
				"type": "bytes32"
			}
		],
		"name": "createExchange",
		"outputs": [
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "docType",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "_infoHash",
				"type": "bytes32"
			}
		],
		"name": "mintINFT",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "_infoHash",
				"type": "bytes32"
			}
		],
		"name": "ownerOf",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "_exchangeID",
				"type": "bytes32"
			}
		],
		"name": "sealExchange",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "_exchangeID",
				"type": "bytes32"
			}
		],
		"name": "signExchange",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes4",
				"name": "interfaceID",
				"type": "bytes4"
			}
		],
		"name": "supportsInterface",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "pure",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_to",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "_infoHash",
				"type": "bytes32"
			}
		],
		"name": "transfer",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	}
]
```
