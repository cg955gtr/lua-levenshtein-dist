local function LevenshteinDistance(StringA: string, StringB: string): number
	if StringA == StringB then
		return 0
	end

	local StringASize = #StringA
	local StringBSize = #StringB

	if StringASize == 0 then
		return StringBSize
	elseif StringBSize == 0 then
		return StringASize
	end

	local Distances = {}

	local FirstMatrix = {}
	Distances[0] = FirstMatrix

	for i = 0, StringBSize do
		FirstMatrix[i] = i
	end

	for i = 1, StringASize do
		local Matrix = { [0] = i }
		Distances[i] = Matrix

		local PreviousMatrix = Distances[i - 1]
		local ACharacter = string.byte(StringA, i)

		for j = 1, StringBSize do
			local BCharacter = string.byte(StringB, j)

			if ACharacter == BCharacter then
				Matrix[j] = PreviousMatrix[j - 1]
			else
				Matrix[j] = math.min(PreviousMatrix[j] + 1, Matrix[j - 1] + 1, PreviousMatrix[j - 1] + 1)
			end
		end
	end

	return Distances[StringASize][StringBSize]
end
