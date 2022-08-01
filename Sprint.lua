task.spawn(function()
					repeat
						task.wait()
						if Sprint["Enabled"] == false then break end
						if br["sprintTable"].sprinting == false then
							br["sprintTable"]:startSprinting()
						end
					until Sprint["Enabled"] == false
				end)
			else
				br["sprintTable"]:stopSprinting()
			end
		end
