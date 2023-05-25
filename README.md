# graphql-create-subgraphql-example
Subgraph example for TheGraph protocol. TheGraph is an indexing protocol to query data for networks like Ethereum and IPFS.

## Table of Contents
- [Getting started](#getting-started)
- [Tips](#tips)
  - [Create new subgraph](#create-new-subgraph)
  - [Graphql Explorer](#ggraphql-explorer)
- [License](#license)

## Getting Started

* Download repository
* Use VS Code IDE :point_right: [download](https://code.visualstudio.com/download)
* Install packages
	```bash
  npm install   
  ```
* Your smart contract has to be published and verified. Example in .\contract\ExampleTheGraph.sol
* Login [TheGraph](https://thegraph.com/studio/) and create subgraph to obtain <SUBGRAPH_SLUG> and <DEPLOY_KEY>
* Edit the following files (add your logic): 
	* src/mapping.ts
		* AssemblyScript code that translates from the event data to the entities defined in your schema.
	* schema.graphql
		* A GraphQL schema that defines what data is stored for your subgraph, and how to query it via GraphQL.
	* subgraph.yaml
		* A YAML file containing the subgraph manifest.
	* networks.json
		* A Json file containing the network where is deployed your smart contract.
	* abis/<SUBGRAPH_SLUG>.json
		* Complete with the abi of your smart contract.
	* package.json
		* Replace <SUBGRAPH_SLUG> and <DEPLOY_KEY>.

	* Be sure to: search and replace all files and text with <SUBGRAPH_SLUG>.
&nbsp;

* Execute in sequence:
	```bash
	npm run codegen
	```
	```bash
	npm run build
	```
	```bash
	npm run auth
	```
	```bash
	npm run deploy
	```

	* Aclaration: If you install package graphprotocol globally, you can use direct command "graph codegen", etc.
&nbsp;

* Access TheGraph and test your subgraph in the browser and enjoy!

## Recomendations:

* Environment:
	* node v18.15.0
	* npm v9.5.0
* Read:
	* https://thegraph.com/docs/en/developing/creating-a-subgraph/
	* https://mirror.xyz/0xB38709B8198d147cc9Ff9C133838a044d78B064B/DdiikBvOLngfOotpqNEoi7gIy9RDlEr0Ztv4yWlYyzc
* Another example.: 
	* https://github.com/graphprotocol/graph-cli/tree/main/examples/example-subgraph


## Tips

### Create new subgraph
---
Execute the next command (replace with the address of your smart contract):
```bash
graph init --product subgraph-studio --from-contract 0x111111111111111111 --network goerli <SUBGRAPH_SLUG>
```

### Graphql Explorer
---
	https://api.studio.thegraph.com/query/XXXXX/<SUBGRAPH_SLUG>/v0.0.X

## License

Is licensed under [The MIT License](LICENSE).