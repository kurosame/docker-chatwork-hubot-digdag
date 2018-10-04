module.exports = (robot) ->
  robot.respond /digdag sample (.*)/i, (msg) ->
    @exec = require("child_process").exec
    @exec "digdag start sample --session now -p sample_param=#{msg.match[1]} -e http://digdag...", (error, stdout, stderr) ->
      attemptIdMatch = /attempt id: (.*)/.exec(stdout)
      msg.send http://digdag.../attempts/#{attemptIdMatch[1]}
