local DestructionSuper = require(game:GetService("ReplicatedStorage").Shared.Classes.Destruction_Super)

local Crater = {}
Crater.__index = Crater

function Crater.new(Origin: Vector3, Lifetime: number, Amount: number, Radius: number, Impact: number?, Size: Vector3?, Tweenfo: TweenInfo?)
    local self = setmetatable(DestructionSuper.new(Lifetime, Amount, Size, Tweenfo, Origin), Crater)

    local rand = Random.new()

    self.Radius = Radius
    self.Impact = Impact or 1
    local rotationAmountPerPart = 360 / self.Amount
    local currentPartRotation = 0

    local partRcParams = RaycastParams.new()
    partRcParams.FilterType = Enum.RaycastFilterType.Exclude

    for i = 0, self.Amount do
        local cf: CFrame = CFrame.new(self.Origin) * CFrame.new(rand:NextNumber(-1, 1), rand:NextNumber(-0.25, 0.25), rand:NextNumber(-1, 1))
        cf *= CFrame.Angles(math.rad(currentPartRotation), 0, 0)
        cf *= CFrame.new(0, self.Size.Y / 2, -self.Radius)
        cf *= CFrame.Angles(0, 0, math.rad(self.Impact)) -- if it looks weird make it negative

        local part = Instance.new("Part")
        part.Anchored = true
        part.Size = self.Size + Vector3.new(rand:NextInteger(-1, 1), rand:NextInteger(-1, 1), rand:NextInteger(-1, 1))
        part.CFrame = cf

        table.insert(self.Parts, part)
        part.Parent = workspace

        partRcParams.FilterDescendantsInstances = {part}
        local rcResults = workspace:Raycast(part.Position, Vector3.new(0, -1, 0), partRcParams)
        if rcResults then
            part.Material = rcResults.Material
            part.Color = rcResults.Instance.Color
        end

        currentPartRotation += rotationAmountPerPart
    end

    return self
end

return Crater