# ###############################
# Creation         : 07-19-15
# Last modification: 02-08-15
# ###############################


# #######################
# Various
# #######################

# When atom starts, we add a new file if no one is opened
# atom.workspace.open() unless atom.workspace.getTextEditors()?.length > 0

# Command for closing all tabs & panes but the current one
# https://discuss.atom.io/t/close-all-other-panes/9993/2
# atom.workspaceView.command 'custom:close-other-panes', ->
atom.commands.add 'atom-text-editor', 'custom:close-other-panes': () ->
  panes = atom.workspace.getPanes()
  activePane = atom.workspace.getActivePaneItem()
  for pane in panes
    pane.destroy() if activePane isnt pane

# #######################
# On packages activation
# #######################

atom.packages.onDidActivatePackage (pack) ->

  # # vim-mode
  # # #################
  #
  # if pack.name == 'vim-mode' || pack.name == 'vim-mode-next'
  #
  #   # No more latency for jk in insert-mode
  #   atom.commands.add 'atom-text-editor', 'insert-comma-in-insert-mode': (e) ->
  #     editor = @getModel()
  #     pos = editor.getCursorBufferPosition()
  #     range = [pos.traverse([0,-1]), pos]
  #     lastChar = editor.getTextInBufferRange(range)
  #     if lastChar != ","
  #       e.abortKeyBinding()

  # Ex-mode commands
  # #################

  if pack.name == 'ex-mode'

    editor = atom.workspace.getActiveTextEditor()
    workspace = atom.views.getView(atom.workspace)
    Ex = pack.mainModule.provideEx()

    # :n ==> Advanced new file
    Ex.registerCommand 'n', ->
      setTimeout ->
        atom.commands.dispatch(workspace , 'advanced-open-file:toggle')
      , 50

    # :qa
    Ex.registerCommand 'qa', ->
      panes = atom.workspace.getPanes()
      for pane in panes
        pane.destroy()

    # :e!
    # Ex.registerCommand 'e!', ->
      # atom.commands.dispatch(editor , 'revert-buffer:revert')
