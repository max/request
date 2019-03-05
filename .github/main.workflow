workflow "build & test" {
  on = "push"
}

action "build" {
  uses = "actions/npm@master"
  args = ["install"]
}

action "test-cov" {
  uses = "actions/npm@master"
  args = ["run", "test-cov"]
}

action "codecov" {
  uses = "actions/npm@master"
  args = ["codecov"]
}

action "coveralls" {
  uses = "actions/npm@master"
  runs = ["sh", "-c", "cat ./coverage/lcov.info"]
}
