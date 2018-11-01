module.exports = {
  "ignore": [
    "README.md",
    ".gitignore"
  ],
  "commands": {
    "Compile": "truffle compile",
    "Migrate": "truffle migrate",
    "Test contracts": "truffle test",
    "Test dapp": "npm test",
    "Run dev server": "npm run start",
    "Build for production": "npm run build"
  },
  "hooks": {
    "post-unpack": "npm install"
  }
};
