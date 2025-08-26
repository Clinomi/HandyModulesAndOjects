local Destruction = {}
Destruction.__index = Destruction

function Destruction.new(Lifetime: number, Amount: number, Size: (number | Vector3), TweenInfo: TweenInfo?, Origin: Vector3)
    local self = setmetatable({}, Destruction)

    self.Lifetime = Lifetime
    self.Origin = Origin
    self.Size = Size
    self.Amount = Amount
    self.TweenInfo = TweenInfo

    self.Parts = {}

    task.delay(self.Lifetime, function()
        self:Destroy()
    end)

    return self
end

function Destruction:Destroy()
    for _, part in self.Parts do
        if part and part:IsA("BasePart") then
            part:Destroy()
        end
    end

    table.clear(self)
end

return Destruction