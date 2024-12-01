import Gtk from 'gi://Gtk'

import {
  musicStatus,
  musicShuffle,
  musicThumbnailUrl,
  musicTitle,
  // musicPlayer,
  toggle,
  next,
  prev,
  shuffle
} from '../../shared/music.js'

function Thumbnail() {
  return Widget.Box({
    className: 'thumbnail',
    css: musicThumbnailUrl
      .bind()
      .transform(thumbnail => `background-image: url("${thumbnail}");`)
  })
}

function MusicMeta() {
  const MusicName = Widget.Label({
    className: 'name',
    label: musicTitle.bind(),
    justification: 'center',
    maxWidthChars: 20,
    truncate: 'end',
    wrap: true,
  })

  return Widget.Box({
    className: 'meta',
    hexpand: true,
    hpack: 'center',
    children: [
      MusicName
    ]
  })
}

function MusicControls() {
  const PrevButton = Widget.Button({
    className: 'prev_button control',
    onPrimaryClick: () => prev(),
    child: Widget.Label('󰒮')
  })

  const PlayButton = Widget.Button({
    className: 'play_button control',
    onPrimaryClick: () => toggle(),
    child: Widget.Label().hook(musicStatus, (self) => {
      if (musicStatus.value === 'Stopped') self.label = '󰓛'
      if (musicStatus.value === 'Playing') self.label = '󰏤'
      if (musicStatus.value === 'Paused') self.label = '󰐊'
    })
  })

  const NextButton = Widget.Button({
    className: 'next_button control',
    onPrimaryClick: () => next(),
    child: Widget.Label('󰒭')
  })

  const ShuffleButton = Widget.Button({
    className: 'shuffle_button control',
    onPrimaryClick: () => shuffle(),
    child: Widget.Label().hook(musicShuffle, (self) => {
      if (musicShuffle.value) self.label = '󰒟'
      if (!musicShuffle.value) self.label = '󰒞'
    })
  })

  const detailsButton = Widget.Button({
    className: 'details_button control',
    child: Widget.Label('󰎇')
  })

  return Widget.Box({
    className: 'controls',
    hpack: 'fill',
    vpack: 'end',
    vexpand: true,
    spacing: 16,
    children: [
      // ShuffleButton,
      // PrevButton,
      // PlayButton,
      // NextButton

      Widget.Box({
        className: 'left_controls',
        children: [ShuffleButton],
        hexpand: true
      }),
      Widget.Box({
        className: 'center_controls',
        children: [PrevButton, PlayButton, NextButton],
        hexpand: true,
        hpack: 'center',
        spacing: 16
      }),
      Widget.Box({
        className: 'right_controls',
        children: [detailsButton],
        hexpand: true,
        hpack: 'end'
      }),
    ]
  })
}

function Music() {
  return Widget.Box({
    className: 'music',
    vertical: true,
    spacing: 10,
    children: [
      Thumbnail(),
      MusicMeta(),
      MusicControls(),
    ]
  })
}

export default new Gtk.Window({
  title: 'Music Player',
  default_width: 325,
  default_height: 425,
  child: Music()
})
