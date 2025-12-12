/**
 * @type {import('semantic-release').GlobalConfig}
 */
module.exports = {
  branches: ["main", "master"],
  plugins: [
    '@semantic-release/commit-analyzer',
    '@semantic-release/release-notes-generator',
    // disable @semantic-release/github to avoid pipeline errors
  ],
};
