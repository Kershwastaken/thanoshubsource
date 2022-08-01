scaffoldtext.Visible = ScaffoldBlockCount["Enabled"]
				BindToStepped("Scaffold", 1, function()
					local helditem = skywars["HotbarController"]:getHeldItemInfo()
					local handcheck = (ScaffoldHandCheck["Enabled"] and helditem and helditem.Block or (not ScaffoldHandCheck["Enabled"]))
					local block, otherblock = getBlock()
					if helditem and helditem.Block then
						block, otherblock = getItem(helditem.Name)
					end

					if block and isAlive() and handcheck then
						if uis:IsKeyDown(Enum.KeyCode.Space) then
							if scaffoldstopmotionval == false then
								scaffoldstopmotionval = true
								scaffoldstopmotionpos = lplr.Character.HumanoidRootPart.CFrame.p
							end
						else
							scaffoldstopmotionval = false
						end
						local woolamount = otherblock.Quantity
						scaffoldtext.Text = (woolamount and tostring(woolamount) or "0")
						if woolamount then
							if woolamount >= 128 then
								scaffoldtext.TextColor3 = Color3.fromRGB(9, 255, 198)
							elseif woolamount >= 64 then
								scaffoldtext.TextColor3 = Color3.fromRGB(255, 249, 18)
							else
								scaffoldtext.TextColor3 = Color3.fromRGB(255, 0, 0)
							end
						end
						if ScaffoldTower["Enabled"] and uis:IsKeyDown(Enum.KeyCode.Space) and uis:GetFocusedTextBox() == nil then
							lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
							if ScaffoldStopMotion["Enabled"] and scaffoldstopmotionval then
								lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(scaffoldstopmotionpos.X, lplr.Character.HumanoidRootPart.CFrame.p.Y, scaffoldstopmotionpos.Z))
							end
						end
						for i = 1, ScaffoldExpand["Value"] do
							local newpos = getScaffold((lplr.Character.Head.Position + ((scaffoldstopmotionval == false and lplr.Character.Humanoid.MoveDirection or Vector3.new(0, 0, 0)) * (i * 3.5))) + Vector3.new(0, -math.floor(lplr.Character.Humanoid.HipHeight * (uis:IsKeyDown(Enum.KeyCode.LeftShift) and ScaffoldDownwards["Enabled"] and 5 or 3) * (lplr.Character:GetAttribute("Transparency") and 1.1 or 1)), 0), ScaffoldDiagonal["Enabled"] and (lplr.Character.HumanoidRootPart.Velocity.Y < 2))
							newpos = Vector3.new(newpos.X, math.clamp(newpos.Y - (uis:IsKeyDown(Enum.KeyCode.Space) and ScaffoldTower["Enabled"] and 4 or 0), -999, 999), newpos.Z)
							if newpos ~= oldpos then
								if not skywars["BlockUtil"].canPlace(newpos) then
									return nil
								end
								local olditem, olditemname = getHeldItem()
								equipItem(block.Name)
								local v18 = block.Block.Ref:Clone();
								v18.Position = newpos;
								v18.Parent = workspace.BlockContainer;
								predictedBlocks[newpos] = v18
								skywars["EventHandler"][skywars["Events"].BlockController.placeBlock[1]](newpos, game:GetService("HttpService"):GenerateGUID(false))
								equipItem(olditemname)
								oldpos = newpos
							end
						end
					end
				end)
			else
				UnbindFromStepped("Scaffold")
				olditem = nil
				scaffoldtext.Visible = false
			end
		end
	})
