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
            [5519] = {
                campaignName = "Caçada à Emissária",
                category = "Fissura de Telogrus",
                faction = "",
                recomendedOrder = 1,
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
            },
            ["5638_A"] = {
                campaignName = "Visões de Azeroth",
                category = "Dalaran",
                faction = "Alliance",
                recomendedOrder = 2,
                keyMissions = {
                    [81930] = {
                        startMissionName = "A guerra interior",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78529,
                        endMissionName = "Impacto profundo",
                    }
                }
            },
            ["5638_H"] = {
                campaignName = "Visões de Azeroth",
                category = "Dalaran",
                faction = "Horde",
                recomendedOrder = 2,
                keyMissions = {
                    [81930] = {
                        startMissionName = "A guerra interna",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78529,
                        endMissionName = "Impacto profundo",
                    }
                }
            },
            [5539] = {
                campaignName = "Limite",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 3,
                keyMissions = {
                    [78529] = {
                        startMissionName = "Impacto profundo",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78536,
                        endMissionName = "Sem chances",
                    }
                }
            },
            [5525] = {
                campaignName = "Fissuras terranas",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 4,
                keyMissions = {
                    [78460] = {
                        startMissionName = "Hipocentro",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78471,
                        endMissionName = "Convergência",
                    }
                }
            },
            [5540] = {
                campaignName = "O primeiro golpe",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 5,
                keyMissions = {
                    [78538] = {
                        startMissionName = "Esforço conjunto",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78546,
                        endMissionName = "Recompensa",
                    }
                }
            },
            [5533] = {
                campaignName = "À Luz de Velas",
                category = "Fosso Ressonante",
                faction = "",
                recomendedOrder = 6,
                keyMissions = {
                    [80434] = {
                        startMissionName = "Profundezas adentro",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78642,
                        endMissionName = "Nova vela, nova esperança",
                    }
                }
            },
            [5534] = {
                campaignName = "Revelações sinistras",
                category = "Fosso Ressonante",
                faction = "",
                recomendedOrder = 7,
                keyMissions = {
                    [80079] = {
                        startMissionName = "Planos em parafuso",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78706,
                        endMissionName = "O segredo do Grão-mensageiro",
                    }
                }
            },
            [5535] = {
                campaignName = "O Monstro e a Máquina",
                category = "Fosso Ressonante",
                faction = "",
                recomendedOrder = 8,
                keyMissions = {
                    [78738] = {
                        startMissionName = "Mensageiro ausente",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 81689,
                        endMissionName = "Orientação: Gundargaz",
                    }
                }
            },
            [5529] = {
                campaignName = "A estrela-guia",
                category = "Pouso Santo",
                faction = "",
                recomendedOrder = 9,
                keyMissions = {
                    [78658] = {
                        startMissionName = "Caminho consagrado",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78671,
                        endMissionName = "A luz da Torre da Aurora",
                    }
                }
            },
            [5530] = {
                campaignName = "Reunindo sombras",
                category = "Pouso Santo",
                faction = "",
                recomendedOrder = 10,
                keyMissions = {
                    [78672] = {
                        startMissionName = "Dever dos luminares",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78954,
                        endMissionName = "Restaure a chama",
                    }
                }
            },
            [5526] = {
                campaignName = "Esperança na solidariedade",
                category = "Pouso Santo",
                faction = "",
                recomendedOrder = 11,
                keyMissions = {
                    [78607] = {
                        startMissionName = "Rumo a Mereldar",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78630,
                        endMissionName = "Desforra em ascensão",
                    }
                }
            },
            [5520] = {
                campaignName = "Amigos na escuridão",
                category = "Azj-Kahet",
                faction = "",
                recomendedOrder = 12,
                keyMissions = {
                    [78384] = {
                        startMissionName = "Siga a luz",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78393,
                        endMissionName = "Uma espécie de trégua",
                    }
                }
            },
            [5521] = {
                campaignName = "Soltar as vítimas capturadas",
                category = "Azj-Kahet",
                faction = "",
                recomendedOrder = 13,
                keyMissions = {
                    [78233] = {
                        startMissionName = "O presente da Fiandeira",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 78256,
                        endMissionName = "O consenso general",
                    }
                }
            },
            [5506] = {
                campaignName = "Planos intermináveis",
                category = "Azj-Kahet",
                faction = "",
                recomendedOrder = 14,
                keyMissions = {
                    [78226] = {
                        startMissionName = "Um convite intrigante",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 84022,
                        endMissionName = "Unindo os Fios Cortados",
                    }
                }
            },
            [5551] = {
                campaignName = "Contra a corrente",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 14.1,
                keyMissions = {
                    [79197] = {
                        startMissionName = "Vínculo com a superfície",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 79344,
                        endMissionName = "Odisseia urbana",
                    }
                }
            },
            [5523] = {
                campaignName = "Laços que unem",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 14.2,
                keyMissions = {
                    [79107] = {
                        startMissionName = "Finda a tempestade",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 79157,
                        endMissionName = "À prova de titãs",
                    }
                }
            },
            [5544] = {
                campaignName = "Notícias lá de baixo",
                category = "Azj=Kahet",
                faction = "",
                recomendedOrder = 14.3,
                keyMissions = {
                    [79224] = {
                        startMissionName = "Colhendo informações",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 79244,
                        endMissionName = "Notícias lá de baixo",
                    }
                }
            },
            [5531] = {
                campaignName = "As Máquinas Marcham para a Guerra",
                category = "Fosso Ressonante",
                faction = "",
                recomendedOrder = 14.4,
                keyMissions = {
                    [79022] = {
                        startMissionName = "Um sinal misterioso",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 79030,
                        endMissionName = "A voz dos Mensageiros",
                    }
                }
            },
            [5550] = {
                campaignName = "Luz na Escuridão",
                category = "Pouso Santo",
                faction = "",
                recomendedOrder = 14.5,
                keyMissions = {
                    [78941] = {
                        startMissionName = "Um maré que precisa virar",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83503,
                        endMissionName = "Retorno a Dornogal",
                    }
                }
            },
            [5664] = {
                campaignName = "Desolação arcana",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 15,
                keyMissions = {
                    [84223] = {
                        startMissionName = "Culpa de sobrevivente",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83643,
                        endMissionName = "Conseguimos sobreviver",
                    }
                }
            },
            [5666] = {
                campaignName = "Força em meio às ruínas",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 16,
                keyMissions = {
                    [83723] = {
                        startMissionName = "Ajuda nunca é demais",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83773,
                        endMissionName = "Adeus, cidade da magia",
                    }
                }
            },
            [5732] = {
                campaignName = "Uma canção de segredos",
                category = "Ilha das Sirenas",
                faction = "",
                recomendedOrder = 16.1,
                keyMissions = {
                    [84719] = {
                        startMissionName = "A expedição aguarda",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 84726,
                        endMissionName = "Mistérios revelados",
                    }
                }
            },
            [5630] = {
                campaignName = "Sombras Duradouras",
                category = "Pouso Santo/Fosso Ressonante",
                faction = "",
                recomendedOrder = 16.2,
                keyMissions = {
                    [82690] = {
                        startMissionName = "Sombras Duradouras",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 82702,
                        endMissionName = "Encontrando amigos",
                    }
                }
            },
            [5617] = {
                campaignName = "Confiança Abalada",
                category = "Fosso Ressonante",
                faction = "",
                recomendedOrder = 17,
                keyMissions = {
                    [83137] = {
                        startMissionName = "A oportunidade foi pro espaço",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83151,
                        endMissionName = "Inframina abaixo",
                    }
                }
            },
            [5661] = {
                campaignName = "Inframina Aguarda",
                category = "Inframina",
                faction = "",
                recomendedOrder = 18,
                keyMissions = {
                    [83096] = {
                        startMissionName = "A Inframina lhe dá as boas-vindas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83176,
                        endMissionName = "Só um palpite",
                    }
                }
            },
            [5614] = {
                campaignName = "Desvendando a Verdade",
                category = "Inframina",
                faction = "",
                recomendedOrder = 19,
                keyMissions = {
                    [83114] = {
                        startMissionName = "Fita vermelha",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83125,
                        endMissionName = "Escalada de preços",
                    }
                }
            },
            [5615] = {
                campaignName = "Arrebentando os Grilhões",
                category = "Inframina",
                faction = "",
                recomendedOrder = 20,
                keyMissions = {
                    [83126] = {
                        startMissionName = "Invasão etérea",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 83130,
                        endMissionName = "Vitória amarga",
                    }
                }
            },
            [5668] = {
                campaignName = "Acender o Combustível da Mudança",
                category = "Inframina",
                faction = "",
                recomendedOrder = 21,
                keyMissions = {
                    [83138] = {
                        startMissionName = "No fim das contas",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 85780,
                        endMissionName = "Bem onde a gente quer",
                    }
                }
            },
            [5694] = {
                campaignName = "Retorno para casa",
                category = "Inframina",
                faction = "",
                recomendedOrder = 22,
                keyMissions = {
                    [86204] = {
                        startMissionName = "Libertação da Inframina: a casa perde",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 87297,
                        endMissionName = "Descontando o cheque",
                    }
                }
            },
            [5684] = {
                campaignName = "Ascensão da Aurora Rubra",
                category = "Planalto Arathi",
                faction = "",
                recomendedOrder = 22.1,
                keyMissions = {
                    [91039] = {
                        startMissionName = "Pedido de Faerin",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 85529,
                        endMissionName = "Glória passada",
                    }
                }
            },
            [5690] = {
                campaignName = "Convite sombrio",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 23,
                keyMissions = {
                    [84956] = {
                        startMissionName = "Convite sombrio",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 84967,
                        endMissionName = "A Guarda Sombria em pedaços",
                    }
                }
            },
            [5733] = {
                campaignName = "Aliança do Caos",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 24,
                keyMissions = {
                    [85032] = {
                        startMissionName = "Sobras do lar",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 90517,
                        endMissionName = "Minha parte do acordo",
                    }
                }
            },
            [5717] = {
                campaignName = "Poder do deserto",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 25,
                keyMissions = {
                    [84826] = {
                        startMissionName = "Ecodomo: Rhovan",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 84910,
                        endMissionName = "O Tabiqa",
                    }
                }
            },
            [5696] = {
                campaignName = "Sombras em guarda",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 26,
                keyMissions = {
                    [84896] = {
                        startMissionName = "A próxima dimensão",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 85037,
                        endMissionName = "É o fim da fita",
                    }
                }
            },
            [5734] = {
                campaignName = "A luz de K'aresh",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 27,
                keyMissions = {
                    [86820] = {
                        startMissionName = "Manaforja Ômega: Dimensius se aproxima",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 86458,
                        endMissionName = "Uma canção pelo futuro",
                    }
                }
            },
            [5707] = {
                campaignName = "Visões Resplandecentes",
                category = "Ilha de Dorn",
                faction = "",
                recomendedOrder = 28,
                keyMissions = {
                    [92405] = {
                        startMissionName = "Encontre Arator",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 85002,
                        endMissionName = "Rumo a Tazavesh",
                    }
                }
            },
            [5708] = {
                campaignName = "Um Encontro com Minn'da",
                category = "K'aresh",
                faction = "",
                recomendedOrder = 29,
                keyMissions = {
                    [85011] = {
                        startMissionName = "Onde em K'aresh está Alleria Correventos?",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 85214,
                        endMissionName = "Medidas desesperadas",
                    }
                }
            },
            [5706] = {
                campaignName = "Caminhos Adiante",
                category = "A Gorja",
                faction = "",
                recomendedOrder = 30,
                keyMissions = {
                    [84935] = {
                        startMissionName = "Erradicação da incursão",
                        startCoordinate = {
                            X = 0,
                            Y = 0,                        
                        },
                        endMissionId = 84949,
                        endMissionName = "Hora decisiva",
                    }
                }
            }
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