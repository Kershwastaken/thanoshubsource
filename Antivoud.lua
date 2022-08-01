spawn(function()
					repeat task.wait() until antivoidypos ~= 0
					repeat
						task.wait(0.2)
						if AntiVoid["Enabled"] and isAlive() then
							local raycastparameters = RaycastParams.new()
							raycastparameters.FilterDescendantsInstances = {workspace.BlockContainer, antivoidpart}
							raycastparameters.FilterType = Enum.RaycastFilterType.Whitelist
							local newray = workspace:Raycast(lplr.Character.HumanoidRootPart.Position, Vector3.new(0, -1000, 0), raycastparameters)
							if newray and newray.Instance == antivoidpart then
								
							else
								lastvalidpos = CFrame.new(newray and newray.Position and (newray.Position + Vector3.new(0, lplr.Character.Humanoid.HipHeight * 2, 0)) or lplr.Character.HumanoidRootPart.CFrame.p)
							end
						end
					until AntiVoid["Enabled"] == false
				end)
				spawn(function()
					repeat task.wait() until antivoidypos ~= 0
					antivoidpart = Instance.new("Part")
					antivoidpart.CanCollide = false
					antivoidpart.Size = Vector3.new(10000, 1, 10000)
					antivoidpart.Anchored = true
					antivoidpart.Transparency = (antitransparent["Enabled"] and 1 or 0.5)
					antivoidpart.Position = Vector3.new(0, 0, 0)
					connectionstodisconnect[#connectionstodisconnect + 1] = antivoidpart.Touched:connect(function(touchedpart)
						if touchedpart.Parent == lplr.Character and isAlive() then
							if antivoidnew["Enabled"] then
								lplr.Character.HumanoidRootPart.CFrame = lastvalidpos + Vector3.new(0, 500, 0)
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
								task.wait(0.1)
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
								task.wait(0.1)
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
								task.wait(0.1)
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
								lplr.Character.HumanoidRootPart.CFrame = lastvalidpos
							else
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, (antivoidmethod["Value"] == "Dynamic" and math.clamp((math.abs(lplr.Character.HumanoidRootPart.Velocity.Y) + 2), 1, 100) or 100), 0)
							end
						end
					end)
					antivoidpart.Parent = workspace
				end)
			else
				if antivoidpart then
					antivoidpart:Remove() 
				end
			end
		end
