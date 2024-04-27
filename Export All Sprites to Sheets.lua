if #app.sprites < 1 then
    app.alert("No sprites open.")
    return
end

for i = 1, #app.sprites do
    app.sprite = app.sprites[i]
    local pathAndTitle = app.fs.filePathAndTitle(app.sprite.filename)
    app.command.ExportSpriteSheet {
        ui = false,
        askOverwrite = false,
        type = SpriteSheetType.PACKED,
        textureFilename = pathAndTitle..".png",
        dataFilename = pathAndTitle..".jase",
        filenameFormat = "{layer}:{frame1}",
        shapePadding = 1,
        trim = true,
        mergeDuplicates = true,
        ignoreEmpty = true,
        splitLayers = true,
    }
end