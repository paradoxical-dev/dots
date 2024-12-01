import GLib from 'gi://GLib'
import Music from './windows/music/Music.js'

const currentTheme = GLib.getenv('SYSTEM_THEME')
const cssFile = App.configDir + '/themes/' + currentTheme + '.css'

Music.set_resizable(false);
Music.show_all()
Music.connect('destroy', () => App.quit())

App.config({
    style: cssFile
})
