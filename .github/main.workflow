workflow "build & test" {
  on = "push"
  resolves = "codecov"
}

action "build" {
  uses = "actions/npm@master"
  args = ["install"]
}

action "test-cov" {
  needs = ["build"]
  uses = "actions/npm@master"
  args = ["run", "test-cov"]
}

action "codecov" {
  needs = ["test-cov"]
  uses = "docker://node"
  runs = "npx"
  args = "codecov"
  secrets = ["CODECOV_TOKEN"]
}

action "coveralls" {
  needs = ["codecov"]
  uses = "docker://alpine"
  runs = ["sh", "-c", "cat ./coverage/lcov.info"]
}
