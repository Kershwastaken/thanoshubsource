if callback then
				BindToRenderStep("Killaura", 1, function() 
					killauranear = false
					if isAlive() then
						local plr = GetAllNearestHumanoidToPosition(killauratargetframe["Players"]["Enabled"], killaurarange["Value"], 100)
						if (killauramouse["Enabled"] and uis:IsMouseButtonPressed(0) or (not killauramouse["Enabled"])) then
							local targettable = {}
							local targetsize = 0
							for i,v in pairs(plr) do
								local localfacing = lplr.Character.HumanoidRootPart.CFrame.lookVector
								local vec = (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).unit
								local angle = math.acos(localfacing:Dot(vec))
								if angle <= math.rad(killauraangle["Value"]) and v.Character:FindFirstChild("Reversed") == nil then
									killauranear = true
									targettable[v.Name] = {
										["UserId"] = v.UserId,
										["Health"] = v.Character.Humanoid.Health,
										["MaxHealth"] = v.Character.Humanoid.MaxHealth
									}
									targetsize = targetsize + 1
									if killauracframe["Enabled"] then
										lplr.Character:SetPrimaryPartCFrame(CFrame.new(lplr.Character.PrimaryPart.Position, Vector3.new(v.Character:FindFirstChild("HumanoidRootPart").Position.X, lplr.Character.PrimaryPart.Position.Y, v.Character:FindFirstChild("HumanoidRootPart").Position.Z)))
									end
									if killauratick <= tick() then
										pcall(function() game:GetService("ReplicatedStorage")[hitremote]:FireServer(v.Character.Torso) end)
										lplr.Character.Humanoid.Animator:LoadAnimation(game:GetService("ReplicatedStorage").Slap):Play()
										killauratick = tick() + 0.1
									end
								end
							end
							targetinfo.UpdateInfo(targettable, targetsize)
						end
					end
				end)
			else
				UnbindFromRenderStep("Killaura")
				killauranear = false
			end
		end
