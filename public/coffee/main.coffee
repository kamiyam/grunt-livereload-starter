do ( d = document, w = window ) ->
## if you use jQiery,please use here
# do ( d = document, w = window ###, $ = jQuery ### ) ->

  log = (str)->
    if (w.console && w.console.log )
      w.console.log str

#  $ ->
#    log ("DOM loaded")

  log("Welcome!")
  return
