const QRNGLedger = artifacts.require("QRNGLedger");

contract("QRNGLedger", () => {
  it("should add a QRNG entry", async () => {
    const ledger = await QRNGLedger.deployed();
    await ledger.addEntry(1, "RandomData123");
    const entries = await ledger.getEntries();
    assert.equal(entries.length, 1, "Entry should be added");
  });
});
