local name, mct = ...
local L_Quests = mct.L_Quests 
local L_Campaigns = mct.L_Campaigns 

CTTCampaignData = {   
    [12] = {
        expansionName = "Midnight",
        expansionOrder = 1,
        campaigns = {
            -- ... (Adicionar restante das séries de missões de Midnight aqui)
        }
    },
    [11] = {
        expansionName = "The War Within",
        expansionOrder = 2,
        campaigns = {
            -- ... (Adicionar restante das séries de missões de The War Within aqui)
        }
    },
    [10] = {
        expansionName = "Dragonflight",
        expansionOrder = 3,
        campaigns = {
            ["1289_A"] = {
                campaignName = "A Expedição Escama de Dragão",
                category = "Introdução de Dragonflight",
                faction = "Alliance",
                recomendedOrder = 1,
                keyMissions = {
                    [65436] = {
                        startMissionName = "As Ilhas do Dragão aguardam",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 69914,
                        endMissionName = "Os despertar dos djaradins",
                    }
                }
            },
            ["1289_H"] = {
                campaignName = "A Expedição Escama de Dragão",
                category = "Introdução de Dragonflight",
                faction = "Horde",
                recomendedOrder = 1,
                keyMissions = {
                    [65435] = {
                        startMissionName = "As Ilhas do Dragão aguardam",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 69914,
                        endMissionName = "Os despertar dos djaradins",
                    }
                }
            },
            ["1299"] = {
                campaignName = "Dragões em Perigo",
                category = "Costa Desperta",
                faction = "",
                recomendedOrder = 2,
                keyMissions = {
                    [65760] = {
                        startMissionName = "Apresentando-se para o serviço",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66001,
                        endMissionName = "Uma última esperança",
                    }
                }
            },
            ["1300"] = {
                campaignName = "Em defesa da vida",
                category = "Costa Desperta",
                faction = "",
                recomendedOrder = 3,
                keyMissions = {
                    [66114] = {
                        startMissionName = "Para o bem da Rainha",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66124,
                        endMissionName = "Saída triunfante",
                    }
                }
            },
            ["1301"] = {
                campaignName = "Aposta de Wrathion",
                category = "Costa Desperta",
                faction = "",
                recomendedOrder = 4,
                keyMissions = {
                    [66079] = {
                        startMissionName = "Wrathion aguarda",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66057,
                        endMissionName = "Restaurando a fé",
                    }
                }
            },
            ["1302"] = {
                campaignName = "Um propósito recuperado",
                category = "Costa Desperta",
                faction = "",
                recomendedOrder = 5,
                keyMissions = {
                    [66779] = {
                        startMissionName = "Herdeiro legítimo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65794,
                        endMissionName = "Uma missão de cuidado",
                    }
                }
            },
            ["1303"] = {
                campaignName = "Chapada adentro",
                category = "Chapada Ohn'ahrana",
                faction = "",
                recomendedOrder = 6,
                keyMissions = {
                    [65795] = {
                        startMissionName = "Próximas estepes",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65806,
                        endMissionName = "Maruukai",
                    }
                }
            },
            ["1304"] = {
                campaignName = "Maruukai",
                category = "Chapada Ohn'ahrana",
                faction = "",
                recomendedOrder = 7,
                keyMissions = {
                    [66016] = {
                        startMissionName = "Clã  Teerai",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65794,
                        endMissionName = "A ameaça Nokhid",
                    }
                }
            },
            ["1305"] = {
                campaignName = "Bênção de Ohn'ahra",
                category = "Chapada Ohn'ahrana",
                faction = "",
                recomendedOrder = 8,
                keyMissions = {
                    [66201] = {
                        startMissionName = "Cascos de guerra",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66259,
                        endMissionName = "Tempestade das Más Novas",
                    }
                }
            },
            ["1306"] = {
                campaignName = "Vínculos renovados",
                category = "Chapada Ohn'ahrana",
                faction = "",
                recomendedOrder = 9,
                keyMissions = {
                    [66327] = {
                        startMissionName = "Caçando o vento",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66783,
                        endMissionName = "Renovação de votos",
                    }
                }
            },
            ["1314"] = {
                campaignName = "Arquivo adentro",
                category = "Vasta Lazuli",
                faction = "",
                recomendedOrder = 10,
                keyMissions = {
                    [66340] = {
                        startMissionName = "Lazúli adentro",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65855,
                        endMissionName = "Ajudando Vasta Lazúli",
                    }
                }
            },
            ["1317"] = {
                campaignName = "Problemas morsanos",
                category = "Vasta Lazuli",
                faction = "",
                recomendedOrder = 11,
                keyMissions = {
                    [66699] = {
                        startMissionName = "Pergunte aos habitantes",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66026,
                        endMissionName = "Ação urgente necessária",
                    }
                }
            },
            ["1316"] = {
                campaignName = "Raízes de decomposição",
                category = "Vasta Lazuli",
                faction = "",
                recomendedOrder = 12,
                keyMissions = {
                    [65838] = {
                        startMissionName = "Entrando em Courambaia",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65911,
                        endMissionName = "Alinhamento lazúli",
                    }
                }
            },
            ["1315"] = {
                campaignName = "Vakthros",
                category = "Vasta Lazuli",
                faction = "",
                recomendedOrder = 13,
                keyMissions = {
                    [66027] = {
                        startMissionName = "Chamando os dragões azuis",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66015,
                        endMissionName = "Pedra do Juramento do dragão azul",
                    }
                }
            },
            ["1310"] = {
                campaignName = "Valdrakken, Cidade dos Dragões",
                category = "Thaldraszus",
                faction = "",
                recomendedOrder = 14,
                keyMissions = {
                    [66244] = {
                        startMissionName = "Destino - Valdrakken",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66252,
                        endMissionName = "Relatório em três vias",
                    }
                }
            },
            ["1324"] = {
                campaignName = "Gerenciamento do Tempo",
                category = "Thaldraszus",
                faction = "",
                recomendedOrder = 15,
                keyMissions = {
                    [66320] = {
                        startMissionName = "O fluxo do tempo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 65962,
                        endMissionName = "A contagem que nunca acaba",
                    }
                }
            },
            ["1323"] = {
                campaignName = "Grande Aventureiro do Tempo",
                category = "Thaldraszus",
                faction = "",
                recomendedOrder = 16,
                keyMissions = {
                    [70040] = {
                        startMissionName = "Caindo através do tempo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66221,
                        endMissionName = "Seguindo em frente",
                    }
                }
            },
            ["5570"] = {
                campaignName = "Câmara dos Encarnados",
                category = "Thaldraszus",
                faction = "",
                recomendedOrder = 17,
                keyMissions = {
                    [70437] = {
                        startMissionName = "Para Baluarte de Tyr",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 72380,
                        endMissionName = "Juntos, somos imbatíveis!",
                    }
                }
            },
            ["1331"] = {
                campaignName = "Um mistério, selado",
                category = "",
                faction = "",
                recomendedOrder = 18,
                keyMissions = {
                    [69093] = {
                        startMissionName = "Um novo mistério",
                        startCoordinate = {
                            X = 45,
                            Y = 55,                        
                        },
                        endMissionId = 66128,
                        endMissionName = "Próximos passos",
                    }
                }
            },
            ["1374"] = {
                campaignName = "Nos salões titânicos",
                category = "",
                faction = "",
                recomendedOrder = 19,
                keyMissions = {
                    [69097] = {
                        startMissionName = "Um cofre não lacrado",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66547,
                        endMissionName = "O lugar disso é no museu... Um dia",
                    }
                }
            },
            ["1362"] = {
                campaignName = "O dever do chefe",
                category = "",
                faction = "",
                recomendedOrder = 20,
                keyMissions = {
                    [68863] = {
                        startMissionName = "Uma tribo perdida",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66444,
                        endMissionName = "Enquanto o ferro está quente",
                    }
                }
            },
            ["1325"] = {
                campaignName = "O propósito de prata",
                category = "A Guarda de Tyr",
                faction = "",
                recomendedOrder = 21,
                keyMissions = {
                    [68794] = {
                        startMissionName = "Ao lado dos dragões",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 67084,
                        endMissionName = "O propósito de prata",
                    }
                }
            },
            ["1308"] = {
                campaignName = "Jardim dos Segredos",
                category = "",
                faction = "",
                recomendedOrder = 22,
                keyMissions = {
                    [66178] = {
                        startMissionName = "Um dia no bosque",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66191,
                        endMissionName = "Tão perto, mas tão longe",
                    }
                }
            },
            ["1309"] = {
                campaignName = "A Sonhadora",
                category = "",
                faction = "",
                recomendedOrder = 23,
                keyMissions = {
                    [66392] = {
                        startMissionName = "Convocando os aliados da natureza",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 66402,
                        endMissionName = "Tal mãe, tal filha",
                    }
                }
            },
            ["1407"] = {
                campaignName = "Velhos ódios",
                category = "",
                faction = "",
                recomendedOrder = 24,
                keyMissions = {
                    [72591] = {
                        startMissionName = "Uma dívida a ser paga",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75258,
                        endMissionName = "Uma palavra final",
                    }
                }
            },
            ["1413"] = {
                campaignName = "Um abrigo dividido",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 25,
                keyMissions = {
                    [74381] = {
                        startMissionName = "Legados escondidos",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 72717,
                        endMissionName = "Um abrigo dividido",
                    }
                }
            },
            ["1392"] = {
                campaignName = "Cavando mais fundo",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 26,
                keyMissions = {
                    [72975] = {
                        startMissionName = "As terras abaixo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75644,
                        endMissionName = "A setecentos palmos do chão",
                    }
                }
            },
            ["1393"] = {
                campaignName = "Legado partido",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 27,
                keyMissions = {
                    [74334] = {
                        startMissionName = "Aspectos futuros",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 72965,
                        endMissionName = "Aspectos de nosso legado",
                    }
                }
            },
            ["1394"] = {
                campaignName = "A barganha ancestral",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 28,
                keyMissions = {
                    [72966] = {
                        startMissionName = "Onde tem fumaça, tem fogo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75145,
                        endMissionName = "No rastro das cinzas",
                    }
                }
            },
            ["1395"] = {
                campaignName = "Pecado herdado",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 29,
                keyMissions = {
                    [72987] = {
                        startMissionName = "Lá vamos nós de novo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 74563,
                        endMissionName = "Pior dos piores",
                    }
                }
            },
            ["1396"] = {
                campaignName = "Confronto inevitável",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 30,
                keyMissions = {
                    [72922] = {
                        startMissionName = "Brasas esmaecidas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 72930,
                        endMissionName = "Impedindo Sarkareth",
                    }
                }
            },
            ["1397"] = {
                campaignName = "Uma chama extinta",
                category = "Brasas de Neltharion",
                faction = "",
                recomendedOrder = 31,
                keyMissions = {
                    [74521] = {
                        startMissionName = "Uma chama extinta",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75417,
                        endMissionName = "Símbolo de Esperança",
                    }
                }
            },
            ["1377"] = {
                campaignName = "Queda de Tyr",
                category = "A Guarda de Tyr",
                faction = "",
                recomendedOrder = 32,
                keyMissions = {
                    [72440] = {
                        startMissionName = "Prata da casa",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 72444,
                        endMissionName = "Um punhado de prata",
                    }
                }
            },
            ["1398"] = {
                campaignName = "Ossuário Velado",
                category = "",
                faction = "",
                recomendedOrder = 33,
                keyMissions = {
                    [72900] = {
                        startMissionName = "O coveiro do ossuário",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 73091,
                        endMissionName = "Floresta do Canto Cristalino",
                    }
                }
            },
            ["5381"] = {
                campaignName = "Coalisão das Chamas",
                category = "",
                faction = "",
                recomendedOrder = 34,
                keyMissions = {
                    [75918] = {
                        startMissionName = "Temporada de fogo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75923,
                        endMissionName = "Soem o alarme",
                    }
                }
            },
            ["5508"] = {
                campaignName = "Reconciliação Bronze",
                category = "",
                faction = "",
                recomendedOrder = 35,
                keyMissions = {
                    [76423] = {
                        startMissionName = "Sem limites",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76422,
                        endMissionName = "Ao Infinito e Além",
                    }
                }
            },
            ["5408"] = {
                campaignName = "Despertar do infinito",
                category = "",
                faction = "",
                recomendedOrder = 36,
                keyMissions = {
                    [76140] = {
                        startMissionName = "Despertar do infinito",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76147,
                        endMissionName = "Retroceder e reconciliar",
                    }
                }
            },
            ["5455"] = {
                campaignName = "Reforjando a Guarda de Tyr",
                category = "A Guarda de Tyr",
                faction = "",
                recomendedOrder = 37,
                keyMissions = {
                    [75632] = {
                        startMissionName = "Um disco deslocado",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 75638,
                        endMissionName = "Disco deslocado encontrado",
                    }
                }
            },
            ["5456"] = {
                campaignName = "Entrar no Sonho",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 38,
                keyMissions = {
                    [76317] = {
                        startMissionName = "O chamado da Sonho",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 77283,
                        endMissionName = "Uma batalha de muitas frentes",
                    }
                }
            },
            ["5471"] = {
                campaignName = "Druidas da Chama",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 39,
                keyMissions = {
                    [77436] = {
                        startMissionName = "A gruta ardente",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76443,
                        endMissionName = "A brasa pegou",
                    }
                }
            },
            ["5472"] = {
                campaignName = "Gelo e fogo",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 40,
                keyMissions = {
                    [76403] = {
                        startMissionName = "Desordem encarnada",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 77178,
                        endMissionName = "Retirada estratégica",
                    }
                }
            },
            ["5460"] = {
                campaignName = "Olho de Ysera",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 41,
                keyMissions = {
                    [76327] = {
                        startMissionName = "Olho de Ysera",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76337,
                        endMissionName = "A brasa ainda queima",
                    }
                }
            },
            ["5465"] = {
                campaignName = "Sonho de campos em chamas",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 42,
                keyMissions = {
                    [76384] = {
                        startMissionName = "Começa a florada",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76401,
                        endMissionName = "Eco das Terras do Fogo",
                    }
                }
            },
            ["5473"] = {
                campaignName = "Novo começo",
                category = "Defensores do Sonho",
                faction = "",
                recomendedOrder = 43,
                keyMissions = {
                    [77780] = {
                        startMissionName = "Testemunho de florada",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 76283,
                        endMissionName = "Andu-falah-dor",
                    }
                }
            },
            ["5538_H"] = {
                campaignName = "A retomada de Guilnéas",
                category = "",
                faction = "Horde",
                recomendedOrder = 44,
                keyMissions = {
                    [78178] = {
                        startMissionName = "Para Guilnéas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 79137,
                        endMissionName = "O muro que nos separa",
                    }
                }
            },
            ["5538_A"] = {
                campaignName = "A retomada de Guilnéas",
                category = "",
                faction = "Alliance",
                recomendedOrder = 44,
                keyMissions = {
                    [78596] = {
                        startMissionName = "Convocação do Lorde Greymane",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78190,
                        endMissionName = "O que deixamos",
                    }
                }
            },
            ["5476"] = {
                campaignName = "O retorno de Tyr",
                category = "A Guarda de Tyr",
                faction = "",
                recomendedOrder = 45,
                keyMissions = {
                    [77339] = {
                        startMissionName = "Recuperação de dados",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 77341,
                        endMissionName = "Logotyrapia",
                    }
                }
            },
            ["5547"] = {
                campaignName = "Irmã pecadora",
                category = "",
                faction = "",
                recomendedOrder = 46,
                keyMissions = {
                    [82229] = {
                        startMissionName = "Um pedido insólito",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 80077,
                        endMissionName = "Irmã pecadora",
                    }
                }
            },
            ["5528"] = {
                campaignName = "Arquivo Azerothiano",
                category = "",
                faction = "",
                recomendedOrder = 47,
                keyMissions = {
                    [77325] = {
                        startMissionName = "Aos arquivos!",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 77331,
                        endMissionName = "O dia da formatura",
                    }
                }
            },
            ["5519_Ep"] = {
                campaignName = "Caçada à Emissária",
                category = "Epílogo de Dragonflight",
                faction = "",
                recomendedOrder = 48,
                keyMissions = {
                    [79009] = {
                        startMissionName = "A Emissária",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 81654,
                        endMissionName = "A Emissária",
                    }
                }
            }
            -- ... (Adicionar restante das séries de missões de Dragonflight aqui)
        }
    },
    --[9] = {
    --    expansionName = "Terras Sombrias",
    --    expansionOrder = 4,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[8] = {
    --    expansionName = "Battle for Azeroth",
    --    expansionOrder = 5,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[7] = {
    --    expansionName = "Legion",
    --    expansionOrder = 6,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[6] = {
    --    expansionName = "Warlords of Draenor",
    --    expansionOrder = 7,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[5] = {
    --    expansionName = "Mists of Pandaria",
    --    expansionOrder = 8,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[4] = {
    --    expansionName = "Cataclysm",
    --    expansionOrder = 9,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[3] = {
    --    expansionName = "Wrath of the Lich King",
    --    expansionOrder = 10,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[2] = {
    --    expansionName = "The Burning Crusade",
    --    expansionOrder = 11,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --},
    --[1] = {
    --    expansionName = "Clássico",
    --    expansionOrder = 12,
    --    campaigns = {
    --        -- ... (Adicionar as séries de missões aqui)
    --    }
    --}
}