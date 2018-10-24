# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

helper = require './helpers.js'

atom.commands.add 'atom-text-editor',
  'user:insert-date': (event) ->
    editor = @getModel()

    now = new Date
    # console.log(now)

    dd = now.getDate()
    dd = "0#{dd}" if dd < 10
    mm = now.getMonth()
    mm+= 1
    mm = "0#{mm}" if mm < 10
    yyyy = now.getFullYear()
    day = ""

    day = "Sunday"          if now.getDay() == 0
    day = "Monday"          if now.getDay() == 1
    day = "Tuesday"         if now.getDay() == 2
    day = "Wednesday"       if now.getDay() == 3
    day = "Thursday"        if now.getDay() == 4
    day = "Friday"          if now.getDay() == 5
    day = "Saturday"        if now.getDay() == 6

    editor.insertText("[#{dd}/#{mm}/#{yyyy}] #{day}")





atom.commands.add 'atom-text-editor',
  'user:uuid': (event) ->
    editor = @getModel()
    # pos = editor.getCursorBufferPosition()
    pos = editor.getCursorBufferPosition()
    atom.commands.dispatch(atom.views.getView(atom.workspace), "guid-me:generate-guid")
    editorContents = helper.stripUuidDashes(editor.getText())
    console.log("user:editorContents  editorContents="+editorContents)
    editor.setText(editorContents)
    editor.setCursorBufferPosition(pos)
    editor.moveToEndOfWord()


atom.commands.add 'atom-text-editor',
  'user:csv-to-json': (event) ->
    console.log("user:csv-to-json")
    editor = @getModel()

    editor.setText(helper.csvToJson(editor.getText()))
    atom.commands.dispatch(atom.views.getView(atom.workspace), "pretty-json:prettify")
    editor.setGrammar(atom.grammars.grammarForScopeName('source.json'))

atom.commands.add 'atom-text-editor',
  'user:json-to-csv': (event) ->
    console.log("user:json-to-csv")
    editor = @getModel()

    editor.setText(helper.jsonToCsv(editor.getText()))
    # atom.commands.dispatch(atom.views.getView(atom.workspace), "pretty-json:prettify")
    editor.setGrammar(atom.grammars.grammarForScopeName('source.text.plain'))






atom.contextMenu.add {
     # '.tree-view .file .name[data-name$=\\.csv]': [{label: 'View as JSON', command: 'user:view-csv-as-json'}]
     # '.tree-view .file .name[data-name$=\\.csv]': [{label: 'View as JSON', command: 'user:csv-to-json'}]
     'atom-text-editor': [{label: 'View as JSON', command: 'user:csv-to-json'}, {label: 'List', command: 'atom-shell-commands:list'}]
 }
