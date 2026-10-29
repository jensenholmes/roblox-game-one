local TestKit = require("./TestKit")
local formatNumber = require("../src/shared/formatNumber")

local describe, it, expect = TestKit.describe, TestKit.it, TestKit.expect

describe("formatNumber", function()
	it("leaves small numbers alone", function()
		expect(formatNumber(0)).toBe("0")
		expect(formatNumber(999)).toBe("999")
	end)

	it("adds commas every three digits", function()
		expect(formatNumber(1250)).toBe("1,250")
		expect(formatNumber(5000000)).toBe("5,000,000")
	end)

	it("drops anything after the decimal point", function()
		expect(formatNumber(1250.7)).toBe("1,250")
	end)
end)
