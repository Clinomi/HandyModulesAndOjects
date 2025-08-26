local DestructionSuper = require(game:GetService("ReplicatedStorage").shared.Objects.Destruction_Super)

local Crater = {}
Crater.__index = Crater

function Crater.new(Origin: Vector3, Lifetime: number, Amount: number, Size: (number | Vector3), TweenInfo: TweenInfo?)
    local self = setmetatable(DestructionSuper.new(Lifetime, Amount, Size, TweenInfo, Origin), Crater)

    local rotationAmountPerPart = 360 / self.Amount
    local currentPartRotation = 0

    for i = 0, self.Amount do
        local cf: CFrame = CFrame.new(self.Origin)
        cf *= CFrame.Angles(math.rad(currentPartRotation), 0, 0)

        local part = Instance.new("Part")
        part.Anchored = true
        part.CFrame = cf

        table.insert(self.Parts, part)
        part.Parent = workspace

        currentPartRotation += rotationAmountPerPart
    end

    return self
end

return Crater