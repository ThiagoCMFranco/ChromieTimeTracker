local name, mct = ...
local L_Quests = mct.L_Quests 
local L_Campaigns = mct.L_Campaigns 

CTTCampaignData = {   
    [12] = {
        expansionName = "Midnight",
        expansionOrder = 1,
        campaigns = {
            [5811] = {
                campaignName = L_Campaigns[5811],
                category = "Ilha de Quel'Danas",
                faction = "",
                recomendedOrder = 1,
                keyMissions = {
                    [91281] = {
                        startMissionName = L_Quests[91281],
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86852,
                        endMissionName = L_Quests[86852],
                    }
                }
            },
            [5719] = {
                campaignName = "Sussurros no Crepúsculo",
                category = "Floresta do Canto Eterno",
                faction = "",
                recomendedOrder = 2,
                keyMissions = {
                    [86733] = {
                        startMissionName = "Negociações em Luaprata",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86745,
                        endMissionName = "Luaprata precisa saber",
                    }
                }
            },
            [5720] = {
                campaignName = "Crepúsculo",
                category = "Floresta do Canto Eterno",
                faction = "",
                recomendedOrder = 3,
                keyMissions = {
                    [86621] = {
                        startMissionName = "O magíster caprichoso",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86636,
                        endMissionName = "O Caos caminha comigo",
                    }
                }
            },
            [5721] = {
                campaignName = "Efeito dominó",
                category = "Floresta do Canto Eterno",
                faction = "",
                recomendedOrder = 4,
                keyMissions = {
                    [86637] = {
                        startMissionName = "Tudo, menos sossego",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86650,
                        endMissionName = "Fraturado",
                    }
                }
            },
            [5722] = {
                campaignName = "Essa terra aqui é nossa",
                category = "Zul'Aman",
                faction = "",
                recomendedOrder = 5,
                keyMissions = {
                    [86708] = {
                        startMissionName = "Os portões de Zul'Aman",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86652,
                        endMissionName = "Deixados nas sombras",
                    }
                }
            },
            [5723] = {
                campaignName = "Caminho dos Hash'ey",
                category = "Zul'Aman",
                faction = "",
                recomendedOrder = 6,
                keyMissions = {
                    [86653] = {
                        startMissionName = "O caminho dos Amani",
                        startCoordinate = {
                            X = 43,
                            Y = 68,                        
                        },
                        endMissionId = 86666,
                        endMissionName = "À sombra do renascimento",
                    }
                }
            },
            [5938] = {
                campaignName = "Onde a guerra repousa",
                category = "Zul'Aman",
                faction = "",
                recomendedOrder = 7,
                keyMissions = {
                    [86681] = {
                        startMissionName = "Covil de Nalorakk: Um gostinho da vingança",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 91958,
                        endMissionName = "Covil de Nalorakk: Imperdoável",
                    }
                }
            },
            [5725] = {
                campaignName = "Os Amani nunca morrem",
                category = "Zul'Aman",
                faction = "",
                recomendedOrder = 8,
                keyMissions = {
                    [86683] = {
                        startMissionName = "Vem, hash'ey",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 91062,
                        endMissionName = "Pontes quebradas",
                    }
                }
            },
            [5726] = {
                campaignName = "Da caverna ao berço",
                category = "Harandar",
                faction = "",
                recomendedOrder = 9,
                keyMissions = {
                    [89402] = {
                        startMissionName = "Harandar",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86944,
                        endMissionName = "Sementes da Fissura",
                    }
                }
            },
            [5724] = {
                campaignName = "O chamado da deusa",
                category = "Harandar",
                faction = "",
                recomendedOrder = 10,
                keyMissions = {
                    [86864] = {
                        startMissionName = "Cuidando do covil",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86890,
                        endMissionName = "Conte aos outros o que viu",
                    }
                }
            },
            [5727] = {
                campaignName = "Emergência",
                category = "Harandar",
                faction = "",
                recomendedOrder = 11,
                keyMissions = {
                    [86883] = {
                        startMissionName = "A marcha frenética",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86898,
                        endMissionName = "A ascensão dos haranir",
                    }
                }
            },
            [5750] = {
                campaignName = "O caminho da Luz",
                category = "Jornada de Arathor",
                faction = "",
                recomendedOrder = 12,
                keyMissions = {
                    [89193] = {
                        startMissionName = "Arator",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 89338,
                        endMissionName = "Arados à obra",
                    }
                }
            },
            [5751] = {
                campaignName = "Arrependimentos do passado",
                category = "Jornada de Arathor",
                faction = "",
                recomendedOrder = 13,
                keyMissions = {
                    [86822] = {
                        startMissionName = "Uma última relíquia",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86903,
                        endMissionName = "Arcantina",
                    }
                }
            },
            [5979] = {
                campaignName = "O Céu Obscurecido",
                category = "Luaprata",
                faction = "",
                recomendedOrder = 13.1,
                keyMissions = {
                    [91854] = {
                        startMissionName = "Sombras Copiosas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 91967,
                        endMissionName = "Você conhece esse mal?",
                    }
                }
            },
            [5728] = {
                campaignName = "Abismo adentro",
                category = "Tempestade do Caos",
                faction = "",
                recomendedOrder = 14,
                keyMissions = {
                    [92061] = {
                        startMissionName = "Tempestade em ascensão",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86565,
                        endMissionName = "Perversos não merecem compaixão",
                    }
                }
            },
            [5729] = {
                campaignName = "O véu da noite",
                category = "Tempestade do Caos",
                faction = "",
                recomendedOrder = 15,
                keyMissions = {
                    [86536] = {
                        startMissionName = "Inimigos úteis",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86545,
                        endMissionName = "Estigma da luz",
                    }
                }
            },
            [5730] = {
                campaignName = "Desforra da Aurora",
                category = "Tempestade do Caos",
                faction = "",
                recomendedOrder = 16,
                keyMissions = {
                    [86509] = {
                        startMissionName = "Aliado ou ameaça",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86522,
                        endMissionName = "Fulgor da alvorada",
                    }
                }
            },
            [5792] = {
                campaignName = "Esteio",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 18,
                keyMissions = {
                    [90777] = {
                        startMissionName = "Alimentando a chama",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 88706,
                        endMissionName = "Nada é para sempre",
                    }
                }
            },
            [5793] = {
                campaignName = "A Torre do Caos",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 19,
                keyMissions = {
                    [90690] = {
                        startMissionName = "Investida da Vanguarda - Não encontrada",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 92520,
                        endMissionName = "Despertar da Nascente da Sombra",
                    }
                }
            },
            [5795] = {
                campaignName = "Encontro dos elfos",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 20,
                keyMissions = {
                    [88922] = {
                        startMissionName = "Os quel'dorei",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 88942,
                        endMissionName = "Os elfos vão à guerra",
                    }
                }
            },
            [88769] = {
                campaignName = "A Batalha da Ponte",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 21,
                keyMissions = {
                    [88769] = {
                        startMissionName = "A batalha da ponte",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 88769,
                        endMissionName = "A batalha da ponte",
                    }
                }
            },
            [5797] = {
                campaignName = "Marcha em Quel'Danas",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 22,
                keyMissions = {
                    [90748] = {
                        startMissionName = "Quel'Danas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 88710,
                        endMissionName = "Marcha em Quel'Danas",
                    }
                }
            },
            [5798] = {
                campaignName = "A aurora de uma nova nascente",
                category = "A Guerra de Luz e Sombra",
                faction = "",
                recomendedOrder = 23,
                keyMissions = {
                    [92689] = {
                        startMissionName = "Um caminho à frente",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 90867,
                        endMissionName = "Das trevas, faz-se a Luz",
                    }
                }
            },
            [6275] = {
                campaignName = "Omnium dos Andassol",
                category = "",
                faction = "",
                recomendedOrder = 24,
                keyMissions = {
                    [96223] = {
                        startMissionName = "O chamado dos magísteres",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 96238,
                        endMissionName = "Return to the Omnium",
                    }
                }
            },
            [6307] = {
                campaignName = "O fólio potencializado",
                category = "",
                faction = "",
                recomendedOrder = 25,
                keyMissions = {
                    [96410] = {
                        startMissionName = "Seeking Knowledge Week 1 of 5: The Omnium Folio",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 96444,
                        endMissionName = "Seeking Knowledge Week 5 of 5: Off-World Magic",
                    }
                }
            },
            [6050] = {
                campaignName = "Legado dos Amani",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 26,
                keyMissions = {
                    [92897] = {
                        startMissionName = "Os preparativos estão completos",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 93012,
                        endMissionName = "Fim da linha",
                    }
                }
            },
            [6229] = {
                campaignName = "Uma ilha de presas",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 27,
                keyMissions = {
                    [92916] = {
                        startMissionName = "Um pedido de ajuda",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 93024,
                        endMissionName = "Vem comigo",
                    }
                }
            },
            [6031] = {
                campaignName = "Fantasmas do passado",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 28,
                keyMissions = {
                    [93454] = {
                        startMissionName = "Palavras necessárias",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 92930,
                        endMissionName = "Escrita pelos vencedores",
                    }
                }
            },
            [6089] = {
                campaignName = "Pecado original",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 29,
                keyMissions = {
                    [92931] = {
                        startMissionName = "Estancar a peçonha",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 92937,
                        endMissionName = "Mal desperto",
                    }
                }
            },
            [6090] = {
                campaignName = "Pecado original",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 30,
                keyMissions = {
                    [93417] = {
                        startMissionName = "Câmaras de Atal'Utek: Altar das Presas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 93419,
                        endMissionName = "A natureza de suas feridas",
                    }
                }
            },
            [6091] = {
                campaignName = "Pecado original",
                category = "A maldição de Ula'tek",
                faction = "",
                recomendedOrder = 29,
                keyMissions = {
                    [92931] = {
                        startMissionName = "Estancar a peçonha",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 92937,
                        endMissionName = "Mal desperto",
                    }
                }
            }
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