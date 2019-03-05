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
  uses = "actions/npm@master"
  runs = ["codecov"]
}

action "coveralls" {
  needs = ["codecov"]
  uses = "docker://alpine"
  runs = ["sh", "-c", "cat ./coverage/lcov.info"]
}
