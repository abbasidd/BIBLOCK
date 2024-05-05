const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
const { ethers } = require("hardhat");

const TotalSupply = 1_000_000_000_000_000n; //1 Trillion

module.exports = buildModule("BIBLOCKModule", (m) => {
  // const unlockTime = m.getParameter("unlockTime", JAN_1ST_2030);
  // const lockedAmount = m.getParameter("lockedAmount", ONE_GWEI);
  const totalSupplyWei = ethers.parseEther(TotalSupply.toString());
  console.log(
    "🚀 ~ module.exports=buildModule ~ totalSupplyWei:",
    totalSupplyWei
  );
  const BIBLOCK = m.contract("BIBLOCK", [totalSupplyWei]);
  return { BIBLOCK };
});
