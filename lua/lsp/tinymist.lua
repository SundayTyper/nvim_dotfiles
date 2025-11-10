return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
  
  settings = {
    exportPdf = 'onSave',
    outputPath = '$root/target/$dir/$name',
  },
}
