Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}


Config = {}

Config.Job = 'police'
Config.CDdispatch = true

--Timer between next ring
Config.Timer = 300

Config.Ped = {
    Pedmodel = "s_m_y_cop_01",
    Pos = {x = -1097.315063, y = -842.498352, z = 19.001619, h = 123.81},
    AskPedText = {text = "Hello how can i help you ?", ChooseText = "~g~[E]~s~ -Hello, I want to call police\n~r~[G]~s~ - Hello, I don't want anything"},
}

Config.PedPos = {
    {x = -1113.831299, y = -826.084595, z = 19.317322, h = 28.86},
    {x = -1110.415405, y = -823.202209, z = 19.319351, h = 35.0},
    {x = -1098.483276, y = -849.199219, z = 19.001694, h = 35.03},
    {x = -1108.173950, y = -839.893860, z = 19.001520, h = 319.55},
}

Lang = {
    ['talk_pd'] = '[E] Talk to PD',
    ['ring'] = 'Pd called a colleague',
    ['already_ring'] = 'Someone has already rung the bell',

    --CDdispatch--
    ['title'] = 'Reception',
    ['message'] = ' Someone is at the reception ',
    ['text'] = 'Reception' --Blip
}