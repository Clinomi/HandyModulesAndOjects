local Destruction = {}
Destruction.__index = Destruction

function Destruction.new(Lifetime: number, Amount: number, Size: Vector3?, Tweenfo: TweenInfo?, Origin: Vector3)
    local self = setmetatable({}, Destruction)

    self.Lifetime = Lifetime
    self.Origin = Origin
    self.Size = Size or Vector3.new(2, 1, 3)
    self.Amount = Amount
    self.TweenInfo = Tweenfo or TweenInfo.new(self.Lifetime * 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    self.Tweens = {} :: {Tween}
    self.Parts = {} :: {Part}

    task.delay(self.Lifetime, function()
        self:Destroy()
    end)

    return self
end

function Destruction:Destroy()
    for _, part in self.Parts do
        if part then
            part:Destroy()
        end
    end

    for _, Tween in self.Tweens do
        if Tween then
            Tween:Destroy()
        end
    end

    table.clear(self)
end

return Destruction