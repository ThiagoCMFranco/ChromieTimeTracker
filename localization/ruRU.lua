--Translator ZamestoTV
if GetLocale() ~= "ruRU" then return end
local _, mct = ...
mct.L = {}
local L = mct.L

L["AddonName"] = "Chromie Time Tracker"
L["DevelopmentTeamCredit"] = "Разработчик |cFFFFFFFFThiago Franco (|cFFFF7C0ATopolino|r-Nemesis [|cFF00AA00Бразилия|r]).|r"
L["LClickAction"] = "ЛКМ: |cFFFFFFFFОткрыть/закрыть окно временной линии.|r"
L["LClickAction_Alternate"] = "ЛКМ: |cFFFFFFFFПереместить иконку альтернативного режима.|r"
L["MClickAction"] = "СКМ: |cFFFFFFFFПоказать сводку активности соратников.|r"
L["MClickAction_Warlords"] = "СКМ: |cFFFFFFFFПоказать сводку гарнизона.|r"
L["MClickAction_Legion"] = "СКМ: |cFFFFFFFFПоказать сводку оплота класса.|r"
L["MClickAction_Missions"] = "СКМ: |cFFFFFFFFПоказать сводку миссий соратников.|r"
L["MClickAction_Covenant"] = "СКМ: |cFFFFFFFFПоказать сводку святилища ковенанта.|r"
L["MClickAction_DragonIsles"] = "СКМ: |cFFFFFFFFПоказать сводку Драконьих островов.|r"
L["MClickAction_KhazAlgar"] = "СКМ: |cFFFFFFFFПоказать сводку Каз-Алгара.|r"
L["RClickAction"] = "ПКМ: |cFFFFFFFFНастройки.|r"
L["ChatAddonLoadedMessage"] = "Chromie Time Tracker успешно загружен! Ваша временная линия: "
L["Timeline"] = "Временная линия: "
L["Settings"] = "Настройки"
L["lblModeSelect"] = "Выбор режима: "
L["CompactMode"] = "Компактный режим"
L["CompactModeDescription"] = "Показывать временную линию в маленьком окне без текста."
L["StandardMode"] = "Стандартный режим"
L["StandardModeDescription"] = "Показывать временную линию в среднем окне с текстом."
L["AlternateMode"] = "Альтернативный режим"
L["AlternateModeDescription"] = "Рекомендуется использовать после того, как больше нельзя путешествовать во времени (уровень 70+). Заменяет текст временной линии на название связанного окна сводки."
L["AdvancedMode"] = "Advanced Mode"
L["AdvancedModeDescription"] = "Show the timeline and a bunch of extra features."
L["HideWhenNotTimeTraveling"] = "Скрывать окно временной линии, когда не используется путешествие во времени Хроми."
L["LockDragDrop"] = "Заблокировать окно."
L["AlternateMode_ShowIconOnly"] = "Показывать только иконку в альтернативном режиме."
L["lblDefaultMiddleClickOption"] = "Опция по умолчанию для СКМ:"
L["MiddleClickOptionDescription"] = "\n|cFFD6AE12Выберите, какая опция будет активирована по умолчанию, когда не путешествуете во времени.\n\n"
L["LockMiddleClickOption"] = "Закрепить выбранную опцию среднего клика для всех временных линий."
L["MiddleClickOption_Warlords"] = "Гарнизон - |cFFA1481DWarlords of Draenor|r"
L["MiddleClickOption_Legion"] = "Оплот класса - |cFF00FF00Legion|r"
L["MiddleClickOption_Missions"] = "Миссии соратников - |cFF056AC4Battle for Azeroth|r"
L["MiddleClickOption_Covenant"] = "Святилище ковенанта - |cFF888888Shadowlands|r"
L["MiddleClickOption_DragonIsles"] = "Сводка Драконьих островов - |cFFC90A67Dragonflight|r"
L["MiddleClickOption_KhazAlgar"] = "Сводка Каз-Алгара - |cFFFF7F27The War Within|r"
L["UndiscoveredContent"]  = "Этот контент еще не открыт.\n"
L["UndiscoveredContent_Warlords"] = "|cFFA1481DГарнизон Дренора|r"
L["UndiscoveredContent_Legion"] = "|cFF00FF00Оплот класса Легиона|r"
L["UndiscoveredContent_Missions"] = "|cFF056AC4Миссии соратников Битвы за Азерот|r"
L["UndiscoveredContent_Covenant"] = "|cFF888888Святилище ковенанта Темных земель|r"
L["UndiscoveredContent_DragonIsles"] = "|cFFC90A67Драконьи острова|r"
L["UndiscoveredContent_KhazAlgar"] = "|cFFFF7F27Каз-Алгар|r"
L["UndiscoveredContentUnlockRequirement_Warlords"] = "\n|cFFFFC90EВыполните задание: Передача полномочий.|r"
L["UndiscoveredContentUnlockRequirement_Legion"] = "\n|cFFFFC90EВыполните задание: Явитесь, защитники!|r"
L["UndiscoveredContentUnlockRequirement_Missions"] = "\n|cFFFFC90EВыполните задание: Незримая война.|r"
L["UndiscoveredContentUnlockRequirement_Covenant"] = "\n|cFFFFC90EВыполните задание: Выбор Предназначения.|r"
L["UndiscoveredContentUnlockRequirement_DragonIsles"] = "\n|cFFFFC90EОтправьтесь на Драконьи острова.|r"
L["UndiscoveredContentUnlockRequirement_KhazAlgar"] = "\n|cFFFFC90EОтправьтесь в Каз-Алгар.|r"
L["ConfigurationMissing"]  = "Окно по умолчанию не выбрано.\n"
L["buttonSave"] = "Сохранить"
L["currentExpansionLabel"] = "Не путешествую во времени"
L["SlashCommands"] = "|cFFFFC90EСписок команд:|r\n|cFFFFC90E/ChromieTimeTracker:|r открыть/закрыть окно временной линии.\n|cFFFFC90E/ctt:|r открыть/закрыть окно временной линии.\n|cFFFFC90E/ctt config:|r открыть окно настроек.\n|cFFFFC90E/Ectt resetPosition:|r сбросить позицию аддона в центр экрана, если случайно вытащили за пределы экрана.\n|cFFFFC90E/ctt resetSettings:|r сбросить настройки аддона на значения по умолчанию.\n|cFFFFC90E/ctt resetAll:|r сбросить позицию аддона в центр экрана и настройки на значения по умолчанию (команды resetSettings и ResetPosition).\n"
L["RunCommandMessage_ResetPosition"] = "Позиция окна и иконки Chromie Time Tracker сброшена."
L["RunCommandMessage_ResetSettings"] = "Настройки Chromie Time Tracker сброшены."
L["RunCommandMessage_ResetAll"] = "Позиция и настройки Chromie Time Tracker сброшены."
L["HideDeveloperCreditOnTooltips"] = "Скрыть информацию о разработчике в подсказках."
L["buttonResetPosition"] = "Сбросить позицию"
L["buttonResetSettings"] = "Сбросить настройки"
L["lblCreditColabList"] = "|cFFFFC90EРазработчик:|r\nThiago Franco (Topolino)\n\n|cFFFFC90EЛокализация:|r\nБразильский португальский (ptBR) - Thiago Franco (Topolino)\nАнглийский (enUS) - Thiago Franco (Topolino)\nРусский (ruRU) - ZamestoTV"
L["About_Title"] = "Легко отслеживайте текущую кампанию Путешествия во времени (Время Хроми)."
L["About_Version"] = C_CTT_VERSION_SEMANTIC_NUMBER
L["About_Line1"] = "Продолжайте использовать аддон, даже когда вы больше не можете участвовать в кампаниях путешествия во времени, с следующими функциями:"
L["About_Line2"] = "Доступ к сводкам и отчётам по следующим зонам:\n- Каз Алгар из The War Within.\n- Драконьи острова из Dragonflight.\n- Святилище ковенанта из Shadowlands.\n- Миссии последователей из Battle for Azeroth.\n- Классовый оплот из Legion.\n- Гарнизон из Warlords of Draenor."
L["About_Line3"] = "Улучшения качества жизни:\n- Отслеживание ресурсов.\n- Проверка времени, оставшегося до истечения задания.\n- Отслеживание доступных миссий эмиссара.\n- Запоминание выбора святилища ковенанта в Shadowlands.\n- Лёгкое переключение между отчётами."
L["About_Line4"] = "Язык определяется на основе выбранного языка World of Warcraft, но не для всех языков доступны переводы. Для языков без перевода используется английский как запасной вариант.\n\nЕсли перевода на ваш язык нет и вы хотите добровольно внести вклад в проект, переведя его, или у вас есть предложения по улучшению или исправлению локализации, пожалуйста, свяжитесь с нами."
L["lblSelectAdvancedModeOptions"] = "Выберите, какие кнопки отображаются в расширенном режиме:"
L["lblSelectContextMenuOptions"] = "Выберите, какие кнопки отображаются в контекстном меню:"
L["ContextMenuTitle"] = "Открыть отчёт"
L["ddlButtonAlignment"] = "Выравнивание кнопок"
L["ddlButtonPosition"] = "Позиция кнопок"
L["alignLeft"] = "Слева"
L["alignCenter"] = "По центру"
L["alignRight"] = "Справа"
L["positionAbove"] = "Сверху"
L["positionBelow"] = "Снизу"
L["EvokerHasNoClassHall"]  = "Класс Пробудитель не имеет классового оплота.\n"
L["Settings_Menu_About"] = "О программе"
L["Settings_Menu_General"] = "Общие"
L["Settings_Menu_Advanced"] = "Расширенный режим"
L["Settings_Menu_Context_Menu"] = "Контекстное меню"
L["Settings_Menu_Alternate"] = "Альтернативный режим"
L["Settings_Menu_Currency"] = "Валюта и ресурсы"
L["Settings_Menu_Enhancements"] = "Улучшения"
L["Settings_Menu_Credit"] = "Авторы"
L["Dialog_Yes"] = "Да"
L["Dialog_No"] = "Нет"
L["Dialog_ResetPosition_Message"] = "Окна аддона будут сброшены в центр экрана. Вы уверены?"
L["Dialog_ResetSettings_Message"] = "Настройки аддона будут сброшены на значения по умолчанию. Вы уверены?"
L["chkAdvShowUnlockedOnly"] = "Показывать только разблокированный контент"
L["chkAdvHideTimelineBox"] = "Скрыть окно временной шкалы"
L["chkShowCurrencyOnReportWindow"] = "Показывать ресурсы в окне отчёта"
L["chkShowCurrencyOnTooltips"] = "Показывать ресурсы в подсказках"
L["chkShowReportTabsOnReportWindow"] = "Показывать ярлыки других отчётов в окнах отчётов"
L["chkShowMissionExpirationTimeOnReportWindow"] = "Показывать оставшееся время до истечения миссии в окнах отчётов"
L["chkShowEmissaryMissionsOnReportWindow"] = "Показывать миссии эмиссара в окнах отчётов (|cFF00FF00Legion|r и |cFF056AC4Battle for Azeroth|r)"
L["Expires_in"] = "Истекает через:"
L["chkHideChatWelcomeMessage"] = "Скрыть сообщение о загрузке аддона в чате."
L["chkHideMainWindow"] = "Скрыть главное окно."
L["ddlToastVisibility"] = "Окно уведомлений при смене временной шкалы"
L["Visibility_Always_Show"] = "Всегда показывать"
L["Visibility_Hide_Current_Timeline"] = "Скрывать, когда не путешествуете во времени"
L["Visibility_Never_Show"] = "Всегда скрывать"
L["EmissaryMissions_Title"] = "Миссии эмиссара"
L["EmissaryMissions_Locked"] = "Миссии эмиссара не были\nвключены."
L["EmissaryMissions_Objective"] = "Цели: "
L["EmissaryMissions_RemainingTime"] = "Оставшееся время: "
L["EmissaryMissions_Reward"] = "Награда: "
L["EmissaryMissions_RemainingTime_Days_S"] = " день, "
L["EmissaryMissions_RemainingTime_Days_P"] = " дней, "
L["EmissaryMissions_RemainingTime_Hours_S"] = " час и "
L["EmissaryMissions_RemainingTime_Hours_P"] = " часов и "
L["EmissaryMissions_RemainingTime_Minutes_S"] = " минута."
L["EmissaryMissions_RemainingTime_Minutes_P"] = " минут."
L["EmissaryMissions_Inactive"] = "Миссия недоступна"
L["EmissaryMissions_RespawnTime_1_Day"] = "Вернитесь завтра, чтобы получить новое задание эмиссара."
L["EmissaryMissions_RespawnTime_2_Day"] = "Вернитесь через два дня, чтобы получить новое задание эмиссара."
L["EmissaryMissions_RespawnTime_3_Day"] = "Вернитесь через три дня, чтобы получить новое задание эмиссара."
L["Welcome"] = "Добро пожаловать"
L["Welcome_Title"] = "Добро пожаловать в"
L["Welcome_New_Line1"] = "Большое спасибо за использование " .. L["AddonName"] .. ", теперь вы сможете наслаждаться множеством функций, улучшающих качество жизни, связанных с временными шкалами, отчётами и сводками по различным зонам."
L["Welcome_New_Line2"] = "Чтобы активировать функции по вашему предпочтению, откройте окно настроек."
L["Welcome_New_Line3"] = "Вы также можете отложить настройку на другое время."
L["Welcome_Upgrade_Line1"] = "Вы используете новую версию " .. L["AddonName"] .. ", могут быть доступны некоторые новые функции и улучшения."
L["Welcome_Upgrade_Line2"] = "Чтобы вручную активировать новые функции этой версии, откройте окно настроек и измените настройки. Чтобы немедленно активировать все функции и сбросить предыдущие настройки, вы можете восстановить настройки по умолчанию."
L["Welcome_Upgrade_Line3"] = "Вы также можете отложить настройку на другое время."
L["Welcome_Downgrade_Line1"] = "Вы используете старую версию " .. L["AddonName"] .. ", некоторые новые функции, улучшения и исправления могут быть недоступны."
L["Welcome_Downgrade_Line2"] = "Мы рекомендуем всегда использовать самую актуальную версию."
L["Welcome_Downgrade_Line3"] = "Если вы вернулись к предыдущей версии из-за проблем в более новой версии, пожалуйста, свяжитесь с нами, чтобы мы могли рассмотреть возможные исправления."
L["buttonOpenSettings"] = "Открыть настройки"
L["buttonKeepSettings"] = "Сохранить настройки"
L["buttonSkipSettings"] = "Настроить позже"
L["chkHideWelcomeWindowInFutureVersionChanges"] = "Не показывать окно приветствия версии при будущих обновлениях."