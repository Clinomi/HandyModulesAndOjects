local AudioPlayer = {}
AudioPlayer.__index = AudioPlayer

function AudioPlayer.new()
    local self = setmetatable({}, AudioPlayer)

    self.Sounds = {} :: {[string]: Sound}

    return self
end

function AudioPlayer:Add(Sound: Sound, Parent: Instance, Properties: {[string]: any}?, PlayUponAdd: boolean?)
    local s = Sound:Clone()

    if Properties then
        for key, value in pairs(Properties) do
            s[key] = value
        end
    end

    if self.Sounds[s.Name] ~= nil then
        self.Sounds[s.Name]:Destroy()
    end

    self.Sounds[s.Name] = s

    s.Parent = Parent

    if PlayUponAdd == true then
        self:Play(s.Name)
    end
end

function AudioPlayer:Play(SoundName: string)
    local s: Sound = self.Sounds[SoundName]

    if s then
        s:Play()

        s.Ended:Once(function()
            s:Destroy()
        end)
    end
end

function AudioPlayer:Destroy()
    for _, sound in pairs(self.Sounds) do
        if sound then
            sound:Destroy()
        end
    end

    table.clear(self)
end

return AudioPlayer