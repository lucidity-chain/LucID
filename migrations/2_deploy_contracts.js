var LucID = artifacts.require("./LucID/LucID.sol");

module.exports = (deployer) => {
    deployer.deploy(LucID, "Lucidity (Beta Test)", "Lucidity ID (Beta test)");
}
