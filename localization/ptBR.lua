--Translator Thiago Franco
if GetLocale() ~= "ptBR" then return end
local _, mct = ...
mct.L = {}
local L = mct.L

L["AddonName"] = "Rastreador de Linha Temporal da Crona"
L["DevelopmentTeamCredit"] = "Desenvolvido por |cFFFFFFFFThiago Franco (|cFFFF7C0ATopolino|r-Nemesis [|cFF00AA00Brasil|r]).|r"
L["LClickAction"] = "Botão Esquerdo: |cFFFFFFFFAlternar exibição da caixa de linha do tempo.|r"
L["LClickAction_Alternate"] = "Botão Esquerdo: |cFFFFFFFFMovimentar ícone.|r"
L["MClickAction"] = "Botão Central: |cFFFFFFFFNenhuma ação configurada.|r"
L["MClickAction_Warlords"] = "Botão Central: |cFFFFFFFFExibir relatório da guarnição.|r"
L["MClickAction_Legion"] = "Botão Central: |cFFFFFFFFExibir relatório do salão de classe.|r"
L["MClickAction_Missions"] = "Botão Central: |cFFFFFFFFExibir relatório de missões de seguidores.|r"
L["MClickAction_Covenant"] = "Botão Central: |cFFFFFFFFExibir relatório do santuário do pacto.|r"
L["MClickAction_DragonIsles"] = "Botão Central: |cFFFFFFFFExibir resumo das Ilhas do Dragão.|r"
L["MClickAction_KhazAlgar"] = "Botão Central: |cFFFFFFFFExibir sumário de Khaz Algar.|r"
L["RClickAction"] = "Botão Direito: |cFFFFFFFFAtalhos e Configurações.|r"
L["ChatAddonLoadedMessage"] = "Rastreador de linha temporal da Crona carregado com sucesso!\nSua linha do tempo: "
L["Timeline"] = "Linha Temporal: "
L["Settings"] = "Configurações"
L["lblModeSelect"] = "Modo de Exibição: "
L["CompactMode"] = "Modo Compacto"
L["CompactModeDescription"] = "Exibe a linha do tempo em uma janela pequena sem rótulo."
L["StandardMode"] = "Modo Normal"
L["StandardModeDescription"] = "Exibe a linha do tempo com rótulo em uma janela de tamanho médio."
L["AlternateMode"] = "Modo Alternativo"
L["AlternateModeDescription"] = "Para uso após desativada a viagem temporal da Crona (nível 70+). Substitui o texto de linha temporal pela identificação do resumo de expansão correspondente."
L["AdvancedMode"] = "Modo Avançado"
L["AdvancedModeDescription"] = "Exibe a linha do tempo e diversas funcionalidades adicionais."
L["HideWhenNotTimeTraveling"] = "Ocultar a janela quando estiver na linha do tempo atual."
L["LockDragDrop"] = "Bloquear movimentação da janela."
L["AlternateMode_ShowIconOnly"] = "Exibir somente ícone quando no modo alternativo."
L["lblDefaultMiddleClickOption"] = "Janela padrão para o clique central:"
L["MiddleClickOptionDescription"] = "\n|cFFD6AE12Selecione a opção padrão do clique do botão central quando não estiver em uma linha do tempo.\n\n"
L["LockMiddleClickOption"] = "Fixar opção de clique do botão central independente da linha do tempo selecionada."
L["MiddleClickOption_Warlords"] = "Guarnição - |cFFA1481DWarlords of Draenor|r"
L["MiddleClickOption_Legion"] = "Salão de Classe - |cFF00FF00Legion|r"
L["MiddleClickOption_Missions"] = "Missões de Seguidor - |cFF056AC4Battle for Azeroth|r"
L["MiddleClickOption_Covenant"] = "Santuário do Pacto %s |cFF888888Shadowlands|r"
L["MiddleClickOption_DragonIsles"] = "Resumo das Ilhas do Dragão - |cFFC90A67Dragonflight|r"
L["MiddleClickOption_KhazAlgar"] = "Sumário de Khaz Algar - |cFFFF7F27The War Within|r"
L["UndiscoveredContent"]  = "O conteúdo ainda não foi desbloqueado.\n"
L["UndiscoveredContent_Warlords"] = "|cFFA1481DGuarnição de Warlords of Draenor|r"
L["UndiscoveredContent_Legion"] = "|cFF00FF00Salão de Classe de Legion|r"
L["UndiscoveredContent_Missions"] = "|cFF056AC4Missões de Battle for Azeroth|r"
L["UndiscoveredContent_Covenant"] = "|cFF888888Santuário do Pacto de Shadowlands|r"
L["UndiscoveredContent_DragonIsles"] = "|cFFC90A67Ilhas do Dragão|r"
L["UndiscoveredContent_KhazAlgar"] = "|cFFFF7F27Khaz Algar|r"
L["UndiscoveredContentUnlockRequirement_Warlords"] = "\n|cFFFFC90ECompletar Missão: Delegando funções.|r"
L["UndiscoveredContentUnlockRequirement_Legion"] = "\n|cFFFFC90ECompletar Missão: Ergam-se, campeões.|r"
L["UndiscoveredContentUnlockRequirement_Missions"] = "\n|cFFFFC90ECompletar Missão: A guerra das sombras.|r"
L["UndiscoveredContentUnlockRequirement_Covenant"] = "\n|cFFFFC90ECompletar Missão: Escolha seu propósito.|r"
L["UndiscoveredContentUnlockRequirement_DragonIsles"] = "\n|cFFFFC90EViajar para As Ilhas do Dragão.|r"
L["UndiscoveredContentUnlockRequirement_KhazAlgar"] = "\n|cFFFFC90EViajar para Khaz Algar. |r"
L["ConfigurationMissing"]  = "Configuração de botão não foi realizada.\n"
L["buttonSave"] = "Salvar"
L["currentExpansionLabel"] = "Atual"
L["SlashCommands"] = "|cFFFFC90ELista de comandos de chat:\n|cFFFFC90E/ChromieTimeTracker:|r alterna exibição da janela de linha temporal.\n/ctt:|r alterna exibição da janela de linha temporal.\n|cFFFFC90E/ctt config:|r abre a janela de configurações.\n/|cFFFFC90Ectt resetPosition:|r redefine o posicionamento das janelas do addon para o centro da tela.\n|cFFFFC90E/ctt resetSettings:|r reedefine as configurações do addon para o padrão de primeiro acesso.\n|cFFFFC90E/ctt resetAll:|r redefine todas as configurações do addon para o estado inicial (resetSettings+ResetPosition).\n"
L["RunCommandMessage_ResetPosition"] = "Posicionamendo de janelas redefinido."
L["RunCommandMessage_ResetSettings"] = "Configurações do addon redefinidas."
L["RunCommandMessage_ResetAll"] = "Posicionamento de janelas e configurações do addon redefinidas."
L["HideDeveloperCreditOnTooltips"] = "Ocultar créditos ao desenvolvedor nas caixas de informação."
L["buttonResetPosition"] = "Redefinir Posições"
L["buttonResetSettings"] = "Redefinir Configurações"
L["lblCreditColabList"] = "|cFFFFC90EDesenvolvimento:|r\nThiago Franco (Topolino)\n\n|cFFFFC90ELocalizações:|r\nPortuguês Brasileiro (ptBR) - Thiago Franco (Topolino)\nInglês (enUS) - Thiago Franco (Topolino)\nRusso (ruRU) - ZamestoTV"
L["About_Title"] = "Identifique facilmente sua linha de campanha de caminhada temporal (Cromie Time)."
L["About_Version"] = "Versão: 2.0.0"
L["About_Line1"] = "Continue utilizando o addon, mesmo quando não puder mais entrar em campanhas de caminhada temporal, com as seguintes funcionalidades:"
L["About_Line2"] = "Acesso aos resumos e relatórios das seguintes áreas:\n- Khaz Algar de The War Within.\n- As Ilhas do Dragão de Dragonflight.\n- Santuário do Pacto de Shadowlands.\n- Missões de Seguidores de Battle for Azeroth.\n- Salão de Classe de Legion.\n- Guarnição de Warlords of Draenor.\n\n- Lembre qual Pacto de Shadowlands está ativo."
L["About_Line3"] = "A definição de idioma é feita a partir o idioma selecionado do World of Warcraft porém não são todos os idiomas que possuem as traduções disponíveis. Idiomas não disponíveis utilizam inglês como retaguarda.\n\nCaso não exista tradução no seu idioma e você queira contribuir voluntariamente com o projeto realizando a tradução ou caso tenha uma sugestão de melhoria ou correção de localização, contate-nos."
L["lblSelectAdvancedModeOptions"] = "Escolha quais botões exibir no modo avançado:"
L["lblSelectContextMenuOptions"] = "Escolha quais botões exibir no menu de contexto:"
L["ContextMenuTitle"] = "Abrir Relatório"
L["ddlButtonAlignment"] = "Alinhamento dos botões"
L["ddlButtonPosition"] = "Posicionamento dos botões"
L["alignLeft"] = "Esquerda"
L["alignCenter"] = "Centralizado"
L["alignRight"] = "Direita"
L["positionAbove"] = "Acima"
L["positionBelow"] = "Abaixo"
L["EvokerHasNoClassHall"]  = "A classe Conjurante não possui um salão de classe.\n"
L["Settings_Menu_About"] = "Sobre"
L["Settings_Menu_General"] = "Geral"
L["Settings_Menu_General_Advanced"] = "Modo Avançado"
L["Settings_Menu_Credit"] = "Créditos"
L["Dialog_Yes"] = "Sim" 
L["Dialog_No"] = "Não"
L["Dialog_ResetPosition_Message"] = "As janelas do addon serão movidas para o centro da tela. Você tem certeza?"
L["Dialog_ResetSettings_Message"] = "O addon será retornado para a configuração padrão. Você tem certeza?"
L["chkAdvShowUnlockedOnly"] = "Exibir somente botões de áreas desbloqueadas"
L["chkAdvHideTimelineBox"] = "Ocultar janela de linha do tempo"
