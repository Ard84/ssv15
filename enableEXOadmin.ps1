Connect-AzureAD
$AutomationAccountName = 'securescoreaut1'
$ResourceGroup = 'atsecurescorenewversion2v12'
$AutomationAccount = Get-AzAutomationAccount -Name $AutomationAccountName -ResourceGroupName $ResourceGroup;   

Write-Host '***** Assing Exchange Role for SP *****';
                        Write-Host '***** Role Exchange Administrator not enabled. Enabling now *****';
                        $RoleTemplate = Get-AzureADDirectoryRoleTemplate | where {$_.displayName -eq 'Exchange Administrator'};
                        Write-Host '----- Exchange Administrator Role Template -----';
                        $RoleTemplate;
                        Write-Host '----- Enabling Exchange Administrator role -----';
                        Enable-AzureADDirectoryRole -RoleTemplateId $RoleTemplate.ObjectId;
                        $AADRole = Get-AzureADDirectoryRole -Filter "DisplayName eq 'Exchange Administrator'";
                        Write-Host '----- AADRole -----';
                        $AADRole;

                    Add-AzureADDirectoryRoleMember -ObjectId $AADRole.ObjectId -RefObjectId $AutomationAccount.Identity.PrincipalId;
                    Write-Host '***** Done *****';
