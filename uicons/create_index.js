const fs = require('fs')

/*
Script should be placed in the root of the UICONS directory

Easiest to either run it with 'node create_index.js' or add it to a package.json file like below then run 'npm start'
  "scripts": {
    "start": "node -e 'require(\"./create_index\").createIndex()'"
  },

Example Implementation: https://github.com/WatWowMap/wwm-uicons
*/

module.exports.update = async function update() {
  const sorter = new Intl.Collator(undefined, { numeric: true, sensitivity: 'base' })
  const checkFolders = async (folder) => {
    folder = folder.replace('//', '/')
    const files = await fs.promises.readdir(folder)
    let newJson = {}
    let hasSubFolders = false

    await Promise.all(files.map(async file => {
      if (!file.includes('.')) {
        hasSubFolders = true
        newJson[file] = await checkFolders(`${folder}/${file}`)
      }
    }))
    if (!hasSubFolders) {
      newJson = files.filter(file => file.includes('.png')).sort(sorter.compare)
    } else {
      const tempJson = newJson
      const sortedKeys = Object.keys(newJson).sort(sorter.compare)
      newJson = {}
      sortedKeys.forEach(key => (newJson[key] = tempJson[key]))
    }
    fs.writeFile(`./${folder === './' ? '' : `${folder}/`}index.json`, JSON.stringify(newJson, null, 2), 'utf8', () => {})
    return newJson
  }
  await checkFolders('./')
}