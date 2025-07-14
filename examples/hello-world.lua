#!/usr/bin/env luajit

print("Hello, World from Lua!")
print("This is a simple example to demonstrate Lua basics.")

local name = "Lua Developer"
local version = jit and jit.version or _VERSION

print(string.format("Welcome, %s!", name))
print(string.format("Running on: %s", version))

local function factorial(n)
    if n <= 1 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print("\nFactorial examples:")
for i = 1, 5 do
    print(string.format("factorial(%d) = %d", i, factorial(i)))
end

local fruits = {"apple", "banana", "orange", "grape"}
print("\nFruits list:")
for i, fruit in ipairs(fruits) do
    print(string.format("%d. %s", i, fruit))
end

local person = {
    name = "John Doe",
    age = 30,
    city = "New York"
}

print("\nPerson info:")
for key, value in pairs(person) do
    print(string.format("%s: %s", key, value))
end