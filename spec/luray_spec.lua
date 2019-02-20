local Luray = require'luray'

describe("luray", function()
    it("has a version",
    function()
        assert.is.string(Luray._VERSION)
    end)
end)
