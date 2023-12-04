function pp(t)
  print("{")
  for k, v in pairs(t) do
    print(k .. " = " .. v .. ",")
  end
  print("}")
end
