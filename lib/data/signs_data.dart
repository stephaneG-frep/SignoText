import '../models/sign_model.dart';

/// Base de données locale des signes LSF (Langue des Signes Française)
/// Données de démonstration — à enrichir avec de vraies ressources visuelles
const List<SignModel> kSignsData = [
  // ─── SALUTATIONS ────────────────────────────────────────────────────────────
  SignModel(
    id: 'bonjour',
    word: 'bonjour',
    category: SignCategory.salutations,
    emoji: '👋',
    description:
        'Main ouverte, doigts joints, paume vers l\'extérieur. Bouger la main de gauche à droite devant le visage, comme un salut.',
    synonyms: ['salut', 'coucou', 'hello'],
    usageExample: 'Bonjour, comment allez-vous ?',
  ),
  SignModel(
    id: 'merci',
    word: 'merci',
    category: SignCategory.salutations,
    emoji: '🙏',
    description:
        'Main plate, doigts joints, paume vers le haut. Partir du menton et avancer la main vers l\'interlocuteur en inclinant légèrement la tête.',
    synonyms: ['remercier', 'gratitude'],
    usageExample: 'Merci beaucoup pour ton aide !',
  ),
  SignModel(
    id: 'au_revoir',
    word: 'au revoir',
    category: SignCategory.salutations,
    emoji: '🫡',
    description:
        'Main ouverte, agiter les doigts de haut en bas ou de gauche à droite. Mouvement doux et répété.',
    synonyms: ['revoir', 'adieu', 'bonne journée'],
    usageExample: 'Au revoir, à bientôt !',
  ),
  SignModel(
    id: 'sil_vous_plait',
    word: "s'il vous plaît",
    category: SignCategory.salutations,
    emoji: '🤲',
    description:
        'Les deux mains plates, paumes vers le haut, légèrement inclinées vers l\'interlocuteur. Geste de supplication douce.',
    synonyms: ['stp', 'svp', "s'il te plaît"],
    usageExample: "S'il vous plaît, pouvez-vous m'aider ?",
  ),
  SignModel(
    id: 'oui',
    word: 'oui',
    category: SignCategory.salutations,
    emoji: '✅',
    description:
        'Poing fermé, pouce levé, ou hochement de tête vers le bas. En LSF, on peut aussi opiner du chef.',
    synonyms: ['d\'accord', 'ok', 'bien sûr'],
    usageExample: 'Oui, je comprends.',
  ),
  SignModel(
    id: 'non',
    word: 'non',
    category: SignCategory.salutations,
    emoji: '❌',
    description:
        'Index et majeur tendus, main qui s\'agite de gauche à droite (geste de refus). Accompagné d\'un mouvement de tête.',
    synonyms: ['pas', 'jamais', 'refus'],
    usageExample: 'Non, ce n\'est pas correct.',
  ),

  // ─── PRONOMS ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'je',
    word: 'je',
    category: SignCategory.pronoms,
    emoji: '👆',
    description:
        'Index pointé vers soi-même, au niveau de la poitrine. Geste naturel de désignation personnelle.',
    synonyms: ['moi', 'me'],
    usageExample: 'Je m\'appelle Marie.',
  ),
  SignModel(
    id: 'toi',
    word: 'toi',
    category: SignCategory.pronoms,
    emoji: '👉',
    description:
        'Index pointé vers l\'interlocuteur. Mouvement direct et clair en direction de la personne désignée.',
    synonyms: ['tu', 'vous', 'te'],
    usageExample: 'Toi, tu comprends ?',
  ),
  SignModel(
    id: 'nous',
    word: 'nous',
    category: SignCategory.pronoms,
    emoji: '🫂',
    description:
        'Index pointé vers soi puis vers l\'interlocuteur, ou mouvement circulaire incluant les deux personnes.',
    synonyms: ['on', 'ensemble'],
    usageExample: 'Nous allons à l\'école.',
  ),
  SignModel(
    id: 'il',
    word: 'il',
    category: SignCategory.pronoms,
    emoji: '👈',
    description:
        'Index pointé vers un côté (droite ou gauche) pour désigner une personne absente ou déjà mentionnée.',
    synonyms: ['elle', 'lui'],
    usageExample: 'Il mange une pomme.',
  ),

  // ─── ACTIONS ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'manger',
    word: 'manger',
    category: SignCategory.actions,
    emoji: '🍽️',
    description:
        'Main en forme de pince (pouce et doigts rapprochés), mouvement répété vers la bouche, comme si l\'on portait de la nourriture.',
    synonyms: ['dîner', 'déjeuner', 'repas', 'avaler'],
    usageExample: 'Je veux manger une pizza.',
  ),
  SignModel(
    id: 'boire',
    word: 'boire',
    category: SignCategory.actions,
    emoji: '🥤',
    description:
        'Main en forme de C (comme si on tenait un verre), amener vers la bouche et incliner légèrement vers le haut.',
    synonyms: ['avaler', 'boisson', 'eau'],
    usageExample: 'Tu veux boire quelque chose ?',
  ),
  SignModel(
    id: 'aider',
    word: 'aider',
    category: SignCategory.actions,
    emoji: '🤝',
    description:
        'Une main à plat (paume vers le haut), l\'autre main en poing posée dessus. Soulever légèrement ensemble.',
    synonyms: ['secourir', 'soutenir', 'assistance', 'aide'],
    usageExample: 'Peux-tu m\'aider s\'il te plaît ?',
  ),
  SignModel(
    id: 'voir',
    word: 'voir',
    category: SignCategory.actions,
    emoji: '👁️',
    description:
        'Index et majeur tendus formant une forme de V, pointer vers les yeux puis vers l\'objet regardé.',
    synonyms: ['regarder', 'observer', 'apercevoir'],
    usageExample: 'Je vois un oiseau.',
  ),
  SignModel(
    id: 'comprendre',
    word: 'comprendre',
    category: SignCategory.actions,
    emoji: '💡',
    description:
        'Index pointé vers la tempe, puis claquer les doigts ou étendre la main brusquement (geste d\'illumination).',
    synonyms: ['saisir', 'appréhender'],
    usageExample: 'Tu comprends ce que je dis ?',
  ),
  SignModel(
    id: 'parler',
    word: 'parler',
    category: SignCategory.actions,
    emoji: '💬',
    description:
        'Index plié, bouger rapidement devant la bouche de haut en bas pour imiter le mouvement des lèvres.',
    synonyms: ['dire', 'communiquer', 'discuter'],
    usageExample: 'Je parle avec mon ami.',
  ),
  SignModel(
    id: 'aimer',
    word: 'aimer',
    category: SignCategory.actions,
    emoji: '❤️',
    description:
        'Les deux poings croisés sur la poitrine (comme une étreinte), puis ouvrir légèrement les mains vers l\'extérieur.',
    synonyms: ['adorer', 'chérir', 'affection', 'amour'],
    usageExample: 'J\'aime ma famille.',
  ),
  SignModel(
    id: 'jouer',
    word: 'jouer',
    category: SignCategory.actions,
    emoji: '🎮',
    description:
        'Les deux mains en forme de Y (pouce et auriculaire tendus), secouer légèrement de haut en bas.',
    synonyms: ['jeu', 's\'amuser', 'divertissement'],
    usageExample: 'Les enfants jouent dans le jardin.',
  ),
  SignModel(
    id: 'dormir',
    word: 'dormir',
    category: SignCategory.actions,
    emoji: '😴',
    description:
        'Main ouverte, paume vers l\'intérieur, poser contre la joue et incliner légèrement la tête. Fermer les yeux.',
    synonyms: ['sommeiller', 'se reposer', 'dodo'],
    usageExample: 'Je veux dormir.',
  ),
  SignModel(
    id: 'courir',
    word: 'courir',
    category: SignCategory.actions,
    emoji: '🏃',
    description:
        'Index et majeur des deux mains, alternés, mimer le mouvement des jambes qui courent.',
    synonyms: ['courir', 'sprint', 'galoper'],
    usageExample: 'Il court vite.',
  ),

  // ─── LIEUX ──────────────────────────────────────────────────────────────────
  SignModel(
    id: 'maison',
    word: 'maison',
    category: SignCategory.lieux,
    emoji: '🏠',
    description:
        'Les deux mains plates forment un toit triangulaire en se rejoignant au-dessus de la tête, puis descendent sur les côtés pour former les murs.',
    synonyms: ['domicile', 'chez moi', 'logement', 'habitation'],
    usageExample: 'Je vais à la maison.',
  ),
  SignModel(
    id: 'ecole',
    word: 'école',
    category: SignCategory.lieux,
    emoji: '🏫',
    description:
        'Main droite plate frappant légèrement le dos de la main gauche (qui reste à plat, représentant le bureau/livre), mouvement répété 2 fois.',
    synonyms: ['classe', 'cours', 'établissement'],
    usageExample: 'L\'école commence à 8h.',
  ),
  SignModel(
    id: 'hopital',
    word: 'hôpital',
    category: SignCategory.lieux,
    emoji: '🏥',
    description:
        'Index droit trace une croix sur le bras gauche (croix rouge). Geste clair et direct.',
    synonyms: ['clinique', 'médecin', 'urgences'],
    usageExample: 'Je vais à l\'hôpital.',
  ),
  SignModel(
    id: 'magasin',
    word: 'magasin',
    category: SignCategory.lieux,
    emoji: '🏪',
    description:
        'Mimer l\'action de rendre la monnaie : main ouverte qui reçoit puis donne, avec un mouvement de transfert.',
    synonyms: ['boutique', 'commerce', 'marché'],
    usageExample: 'Je vais au magasin.',
  ),

  // ─── FAMILLE ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'famille',
    word: 'famille',
    category: SignCategory.famille,
    emoji: '👨‍👩‍👧‍👦',
    description:
        'Les deux mains en F (pouce et index formant un cercle), faire un cercle horizontal devant soi pour inclure tout le groupe.',
    synonyms: ['parents', 'proches', 'membres'],
    usageExample: 'Ma famille est grande.',
  ),
  SignModel(
    id: 'mere',
    word: 'mère',
    category: SignCategory.famille,
    emoji: '👩',
    description:
        'Pouce de la main droite touche la joue droite, puis s\'éloigne. Geste doux et lent.',
    synonyms: ['maman', 'ma mère'],
    usageExample: 'Ma mère s\'appelle Sophie.',
  ),
  SignModel(
    id: 'pere',
    word: 'père',
    category: SignCategory.famille,
    emoji: '👨',
    description:
        'Pouce de la main droite touche le front, puis s\'éloigne. Geste vers le haut du visage.',
    synonyms: ['papa', 'mon père'],
    usageExample: 'Mon père travaille beaucoup.',
  ),

  // ─── NOURRITURE ─────────────────────────────────────────────────────────────
  SignModel(
    id: 'eau',
    word: 'eau',
    category: SignCategory.nourriture,
    emoji: '💧',
    description:
        'La lettre W en alphabet manuel (index, majeur et annulaire tendus) touchée contre les lèvres, puis avancer légèrement.',
    synonyms: ['boisson', 'boire'],
    usageExample: 'Je veux de l\'eau.',
  ),
  SignModel(
    id: 'pain',
    word: 'pain',
    category: SignCategory.nourriture,
    emoji: '🍞',
    description:
        'Main droite courbée fait un mouvement de coupe sur le bras gauche (mimer une miche de pain qu\'on tranche).',
    synonyms: ['baguette', 'tartine'],
    usageExample: 'Passe-moi le pain s\'il te plaît.',
  ),
  SignModel(
    id: 'pomme',
    word: 'pomme',
    category: SignCategory.nourriture,
    emoji: '🍎',
    description:
        'Poing semi-fermé, pouce levé, pivoter légèrement devant la bouche comme si on croquait dans une pomme.',
    synonyms: ['fruit'],
    usageExample: 'Je mange une pomme.',
  ),

  // ─── ANIMAUX ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'chat',
    word: 'chat',
    category: SignCategory.animaux,
    emoji: '🐱',
    description:
        'Index et pouce des deux mains miment les moustaches du chat, tirées vers les côtés à partir de la bouche.',
    synonyms: ['félin', 'minet', 'chaton'],
    usageExample: 'J\'ai un chat.',
  ),
  SignModel(
    id: 'chien',
    word: 'chien',
    category: SignCategory.animaux,
    emoji: '🐶',
    description:
        'Claquer les doigts puis pointer vers le bas (comme pour appeler un chien). Mouvement naturel et expressif.',
    synonyms: ['toutou', 'chiot'],
    usageExample: 'Mon chien s\'appelle Rex.',
  ),

  // ─── ÉMOTIONS ───────────────────────────────────────────────────────────────
  SignModel(
    id: 'content',
    word: 'content',
    category: SignCategory.emotions,
    emoji: '😊',
    description:
        'Main plate sur la poitrine, mouvement circulaire vers le haut (sentiment qui monte). Expression faciale heureuse.',
    synonyms: ['heureux', 'joyeux', 'ravi', 'joie', 'bonheur'],
    usageExample: 'Je suis très content.',
  ),
  SignModel(
    id: 'triste',
    word: 'triste',
    category: SignCategory.emotions,
    emoji: '😢',
    description:
        'Les deux mains ouvertes, paumes vers soi, glissent vers le bas devant le visage (larmes qui coulent). Expression faciale abattue.',
    synonyms: ['malheureux', 'déprimé', 'tristesse'],
    usageExample: 'Je suis triste aujourd\'hui.',
  ),
  SignModel(
    id: 'fatigue',
    word: 'fatigué',
    category: SignCategory.emotions,
    emoji: '😩',
    description:
        'Les deux mains ouvertes sur la poitrine, doigts pointés vers le haut, s\'affaissent vers le bas (manque d\'énergie).',
    synonyms: ['fatigué', 'épuisé', 'fatigue'],
    usageExample: 'Je suis fatigué après le travail.',
  ),

  // ─── FAMILLE (suite) ────────────────────────────────────────────────────────
  SignModel(
    id: 'frere',
    word: 'frère',
    category: SignCategory.famille,
    emoji: '👦',
    description:
        'Index pointé vers la tempe, puis signe masculin (pouce sur la tempe). Désigne un homme de la famille.',
    synonyms: ['frérot'],
    usageExample: 'Mon frère s\'appelle Lucas.',
  ),
  SignModel(
    id: 'soeur',
    word: 'sœur',
    category: SignCategory.famille,
    emoji: '👧',
    description:
        'Index pointé vers la joue, puis signe féminin (pouce sur la joue). Désigne une femme de la famille.',
    synonyms: ['frangine'],
    usageExample: 'Ma sœur est médecin.',
  ),
  SignModel(
    id: 'grand_mere',
    word: 'grand-mère',
    category: SignCategory.famille,
    emoji: '👵',
    description:
        'Signe "mère" (pouce sur la joue) puis un mouvement vers l\'avant ou vers le bas pour indiquer une génération au-dessus.',
    synonyms: ['mamie', 'mémé', 'grand-maman'],
    usageExample: 'Ma grand-mère fait de bons gâteaux.',
  ),
  SignModel(
    id: 'grand_pere',
    word: 'grand-père',
    category: SignCategory.famille,
    emoji: '👴',
    description:
        'Signe "père" (pouce sur le front) puis un mouvement vers l\'avant pour indiquer une génération au-dessus.',
    synonyms: ['papi', 'pépé', 'grand-papa'],
    usageExample: 'Mon grand-père a 75 ans.',
  ),
  SignModel(
    id: 'enfant',
    word: 'enfant',
    category: SignCategory.famille,
    emoji: '🧒',
    description:
        'Main à plat, paume vers le bas, à hauteur basse (comme pour indiquer la taille d\'un enfant). Peut être répété.',
    synonyms: ['petit', 'gamin', 'gosse'],
    usageExample: 'L\'enfant joue dans le jardin.',
  ),
  SignModel(
    id: 'ami',
    word: 'ami',
    category: SignCategory.famille,
    emoji: '🤝',
    description:
        'Les deux index se crochètent l\'un dans l\'autre, formant un lien. Geste simple et expressif.',
    synonyms: ['copain', 'camarade', 'amie'],
    usageExample: 'C\'est mon meilleur ami.',
  ),

  // ─── NOURRITURE (suite) ──────────────────────────────────────────────────────
  SignModel(
    id: 'lait',
    word: 'lait',
    category: SignCategory.nourriture,
    emoji: '🥛',
    description:
        'Mouvement d\'ouverture et fermeture de la main (comme si on pressait un pis de vache), répété 2 fois.',
    synonyms: ['boisson blanche'],
    usageExample: 'Je bois un verre de lait.',
  ),
  SignModel(
    id: 'cafe',
    word: 'café',
    category: SignCategory.nourriture,
    emoji: '☕',
    description:
        'Mouvement circulaire avec l\'index au-dessus d\'une main à plat (mimer le mouvement d\'un moulin à café).',
    synonyms: ['expresso', 'café noir'],
    usageExample: 'Je veux un café s\'il vous plaît.',
  ),
  SignModel(
    id: 'the',
    word: 'thé',
    category: SignCategory.nourriture,
    emoji: '🍵',
    description:
        'Mimer une tasse tenue entre les doigts, puis souffler dessus légèrement. Ou : lettre T en alphabet manuel.',
    synonyms: ['tisane', 'infusion'],
    usageExample: 'Tu veux du thé ou du café ?',
  ),
  SignModel(
    id: 'viande',
    word: 'viande',
    category: SignCategory.nourriture,
    emoji: '🥩',
    description:
        'Pincer la peau entre le pouce et l\'index de la main gauche, la secouer légèrement.',
    synonyms: ['steak', 'bœuf', 'poulet'],
    usageExample: 'Je mange de la viande ce soir.',
  ),
  SignModel(
    id: 'legume',
    word: 'légume',
    category: SignCategory.nourriture,
    emoji: '🥦',
    description:
        'La lettre L en alphabet manuel (index et pouce tendus en L), pivotée devant la bouche.',
    synonyms: ['légumes', 'verdure', 'salade'],
    usageExample: 'Mange tes légumes !',
  ),
  SignModel(
    id: 'fruit',
    word: 'fruit',
    category: SignCategory.nourriture,
    emoji: '🍎',
    description:
        'La lettre F en alphabet manuel (pouce et index en cercle), paume vers le haut, mouvement légèrement vers l\'avant.',
    synonyms: ['fruits'],
    usageExample: 'J\'aime les fruits frais.',
  ),
  SignModel(
    id: 'gateau',
    word: 'gâteau',
    category: SignCategory.nourriture,
    emoji: '🎂',
    description:
        'Les deux mains à plat superposées (comme des couches de gâteau), puis mimer l\'action de couper avec un index.',
    synonyms: ['dessert', 'pâtisserie', 'tarte'],
    usageExample: 'On mange le gâteau d\'anniversaire.',
  ),
  SignModel(
    id: 'chocolat',
    word: 'chocolat',
    category: SignCategory.nourriture,
    emoji: '🍫',
    description:
        'Index de la main droite trace un cercle sur le dos de la main gauche (mimer le mouvement de râper du chocolat).',
    synonyms: ['cacao', 'choco'],
    usageExample: 'J\'adore le chocolat.',
  ),

  // ─── ANIMAUX (suite) ─────────────────────────────────────────────────────────
  SignModel(
    id: 'oiseau',
    word: 'oiseau',
    category: SignCategory.animaux,
    emoji: '🐦',
    description:
        'Pouce et index pincés près de la bouche, s\'ouvrir et fermer comme un bec. Les autres doigts repliés.',
    synonyms: ['pigeon', 'moineau', 'canari'],
    usageExample: 'L\'oiseau chante dans l\'arbre.',
  ),
  SignModel(
    id: 'lapin',
    word: 'lapin',
    category: SignCategory.animaux,
    emoji: '🐰',
    description:
        'Les deux index et majeurs tendus sur le sommet de la tête (oreilles de lapin), plier et redresser 2 fois.',
    synonyms: ['lapereau', 'lièvre'],
    usageExample: 'Le lapin mange une carotte.',
  ),
  SignModel(
    id: 'poisson',
    word: 'poisson',
    category: SignCategory.animaux,
    emoji: '🐟',
    description:
        'Main à plat, doigts joints, ondulation de la main de gauche à droite (mouvement de nage d\'un poisson).',
    synonyms: ['poissons'],
    usageExample: 'J\'ai un poisson rouge.',
  ),

  // ─── LIEUX (suite) ───────────────────────────────────────────────────────────
  SignModel(
    id: 'restaurant',
    word: 'restaurant',
    category: SignCategory.lieux,
    emoji: '🍴',
    description:
        'Mimer l\'action de manger (signe "manger") puis pointer vers un endroit extérieur. Ou : les deux mains imitent couteau et fourchette.',
    synonyms: ['resto', 'brasserie', 'cantine'],
    usageExample: 'On mange au restaurant ce soir ?',
  ),
  SignModel(
    id: 'ville',
    word: 'ville',
    category: SignCategory.lieux,
    emoji: '🏙️',
    description:
        'Les deux mains forment alternativement des toits de maisons (triangles), en les déplaçant horizontalement pour évoquer plusieurs bâtiments.',
    synonyms: ['cité', 'agglomération', 'Paris'],
    usageExample: 'Je vis en ville.',
  ),
  SignModel(
    id: 'jardin',
    word: 'jardin',
    category: SignCategory.lieux,
    emoji: '🌳',
    description:
        'Les deux mains à plat, paumes vers le bas, effectuent un mouvement d\'épandage (comme si on dispersait des graines sur le sol).',
    synonyms: ['parc', 'jardin public', 'pelouse'],
    usageExample: 'Les enfants jouent dans le jardin.',
  ),
  SignModel(
    id: 'travail',
    word: 'travail',
    category: SignCategory.actions,
    emoji: '💼',
    description:
        'Les deux poings frappent légèrement l\'un sur l\'autre par le côté du poignet, mouvement répété 2 fois.',
    synonyms: ['boulot', 'emploi', 'travailler'],
    usageExample: 'Je vais au travail.',
  ),
  SignModel(
    id: 'apprendre',
    word: 'apprendre',
    category: SignCategory.actions,
    emoji: '📖',
    description:
        'Main droite à plat posée sur la paume gauche, puis amener la main droite vers la tête (comme prendre une information pour la mettre dans la tête).',
    synonyms: ['étudier', 'mémoriser', 'apprendre'],
    usageExample: 'J\'apprends le LSF.',
  ),
  SignModel(
    id: 'vouloir',
    word: 'vouloir',
    category: SignCategory.actions,
    emoji: '🙋',
    description:
        'Main ouverte, paume vers le haut, ramener vers soi en fermant légèrement les doigts (geste de désir/attraction).',
    synonyms: ['désirer', 'souhaiter', 'avoir envie'],
    usageExample: 'Je veux de l\'eau.',
  ),
  SignModel(
    id: 'aller',
    word: 'aller',
    category: SignCategory.actions,
    emoji: '➡️',
    description:
        'Index pointé vers l\'avant, mouvement vers l\'avant. La direction peut changer selon la destination.',
    synonyms: ['partir', 'se rendre', 'avancer'],
    usageExample: 'Je vais à l\'école.',
  ),
  SignModel(
    id: 'venir',
    word: 'venir',
    category: SignCategory.actions,
    emoji: '↩️',
    description:
        'Index pointé vers l\'avant, puis ramener vers soi (mouvement inverse de "aller").',
    synonyms: ['arriver', 'rapprocher'],
    usageExample: 'Tu viens avec moi ?',
  ),
  SignModel(
    id: 'donner',
    word: 'donner',
    category: SignCategory.actions,
    emoji: '🎁',
    description:
        'Main ouverte, paume vers le haut, mouvement vers l\'interlocuteur (offrir quelque chose).',
    synonyms: ['offrir', 'remettre', 'transmettre'],
    usageExample: 'Je te donne ce livre.',
  ),
  SignModel(
    id: 'attendre',
    word: 'attendre',
    category: SignCategory.actions,
    emoji: '⏳',
    description:
        'Les deux mains ouvertes devant soi, doigts écartés, légèrement tremblantes (état de patience, d\'attente suspendue).',
    synonyms: ['patienter', 'patience'],
    usageExample: 'Attends-moi s\'il te plaît.',
  ),

  // ─── COULEURS ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'rouge',
    word: 'rouge',
    category: SignCategory.couleurs,
    emoji: '🔴',
    description:
        'Index de la main droite frotte la lèvre inférieure de gauche à droite (couleur associée aux lèvres).',
    synonyms: ['cramoisi', 'écarlate'],
    usageExample: 'Ma veste est rouge.',
  ),
  SignModel(
    id: 'bleu',
    word: 'bleu',
    category: SignCategory.couleurs,
    emoji: '🔵',
    description:
        'La lettre B en alphabet manuel (main ouverte, doigts tendus, pouce plié) pivotée devant soi.',
    synonyms: ['azur', 'bleu ciel', 'marine'],
    usageExample: 'Le ciel est bleu.',
  ),
  SignModel(
    id: 'vert',
    word: 'vert',
    category: SignCategory.couleurs,
    emoji: '🟢',
    description:
        'La lettre V en alphabet manuel (index et majeur en V) pivotée devant soi, paume vers l\'extérieur.',
    synonyms: ['verdâtre', 'vert foncé', 'vert clair'],
    usageExample: 'L\'herbe est verte.',
  ),
  SignModel(
    id: 'jaune',
    word: 'jaune',
    category: SignCategory.couleurs,
    emoji: '🟡',
    description:
        'La lettre J en alphabet manuel (petit doigt levé, tracer un J dans l\'air) ou pivot de la lettre Y.',
    synonyms: ['doré', 'jaune citron'],
    usageExample: 'Le soleil est jaune.',
  ),
  SignModel(
    id: 'blanc',
    word: 'blanc',
    category: SignCategory.couleurs,
    emoji: '⬜',
    description:
        'Main ouverte sur la poitrine, doigts écartés, tirer légèrement vers l\'extérieur comme pour montrer une chemise blanche.',
    synonyms: ['clair', 'ivoire'],
    usageExample: 'La neige est blanche.',
  ),
  SignModel(
    id: 'noir',
    word: 'noir',
    category: SignCategory.couleurs,
    emoji: '⬛',
    description:
        'Index frotte le bord du sourcil de gauche à droite (couleur associée aux sourcils foncés).',
    synonyms: ['foncé', 'sombre', 'obscur'],
    usageExample: 'Mon chat est noir.',
  ),
  SignModel(
    id: 'orange',
    word: 'orange',
    category: SignCategory.couleurs,
    emoji: '🟠',
    description:
        'Mouvement d\'ouverture et fermeture de la main devant la bouche (mimer l\'action de presser une orange).',
    synonyms: ['orangé', 'mandarine'],
    usageExample: 'J\'aime la couleur orange.',
  ),
  SignModel(
    id: 'rose',
    word: 'rose',
    category: SignCategory.couleurs,
    emoji: '🌸',
    description:
        'Index recourbé frotte légèrement la joue (couleur douce et délicate).',
    synonyms: ['rose pâle', 'fuchsia', 'saumon'],
    usageExample: 'Sa robe est rose.',
  ),
  SignModel(
    id: 'violet',
    word: 'violet',
    category: SignCategory.couleurs,
    emoji: '🟣',
    description:
        'La lettre V puis la lettre T formées rapidement (contraction de "violet"), ou mouvement circulaire devant la gorge.',
    synonyms: ['mauve', 'lilas', 'pourpre'],
    usageExample: 'J\'adore la couleur violette.',
  ),

  // ─── CHIFFRES ────────────────────────────────────────────────────────────────
  SignModel(
    id: 'un',
    word: 'un',
    category: SignCategory.chiffres,
    emoji: '1️⃣',
    description: 'Index tendu, autres doigts repliés. Paume vers l\'interlocuteur.',
    synonyms: ['1', 'premier', 'une'],
    usageExample: 'Je veux un café.',
  ),
  SignModel(
    id: 'deux',
    word: 'deux',
    category: SignCategory.chiffres,
    emoji: '2️⃣',
    description: 'Index et majeur tendus (signe V), paume vers l\'interlocuteur.',
    synonyms: ['2', 'deuxième', 'deux fois'],
    usageExample: 'J\'ai deux enfants.',
  ),
  SignModel(
    id: 'trois',
    word: 'trois',
    category: SignCategory.chiffres,
    emoji: '3️⃣',
    description: 'Index, majeur et annulaire tendus, paume vers l\'interlocuteur.',
    synonyms: ['3', 'troisième'],
    usageExample: 'Il est 3 heures.',
  ),
  SignModel(
    id: 'quatre',
    word: 'quatre',
    category: SignCategory.chiffres,
    emoji: '4️⃣',
    description: 'Index, majeur, annulaire et auriculaire tendus (4 doigts), pouce replié.',
    synonyms: ['4', 'quatrième'],
    usageExample: 'Quatre personnes sont là.',
  ),
  SignModel(
    id: 'cinq',
    word: 'cinq',
    category: SignCategory.chiffres,
    emoji: '5️⃣',
    description: 'Les 5 doigts tendus et écartés, paume vers l\'interlocuteur.',
    synonyms: ['5', 'cinquième'],
    usageExample: 'J\'ai cinq ans.',
  ),
  SignModel(
    id: 'dix',
    word: 'dix',
    category: SignCategory.chiffres,
    emoji: '🔟',
    description: 'Les deux mains à 5 doigts tendus simultanément, ou pouce levé agité.',
    synonyms: ['10', 'dixième'],
    usageExample: 'J\'ai dix euros.',
  ),
  SignModel(
    id: 'cent',
    word: 'cent',
    category: SignCategory.chiffres,
    emoji: '💯',
    description: 'Lettre C en alphabet manuel (main en demi-cercle), puis lettre T ou chiffre 1.',
    synonyms: ['100', 'centième'],
    usageExample: 'Ça coûte cent euros.',
  ),

  // ─── CORPS ───────────────────────────────────────────────────────────────────
  SignModel(
    id: 'tete',
    word: 'tête',
    category: SignCategory.corps,
    emoji: '🗣️',
    description:
        'Pointer l\'index vers la tempe ou tapoter légèrement le sommet de la tête.',
    synonyms: ['crâne', 'cerveau'],
    usageExample: 'J\'ai mal à la tête.',
  ),
  SignModel(
    id: 'main',
    word: 'main',
    category: SignCategory.corps,
    emoji: '✋',
    description:
        'La main droite ouverte tapote le dos de la main gauche ouverte.',
    synonyms: ['mains', 'paume', 'doigt'],
    usageExample: 'Lave-toi les mains.',
  ),
  SignModel(
    id: 'yeux',
    word: 'yeux',
    category: SignCategory.corps,
    emoji: '👀',
    description:
        'Index et majeur pointés vers les yeux (ou juste l\'index qui pointe vers l\'œil).',
    synonyms: ['œil', 'regard', 'vue'],
    usageExample: 'J\'ai les yeux bleus.',
  ),
  SignModel(
    id: 'bouche',
    word: 'bouche',
    category: SignCategory.corps,
    emoji: '👄',
    description:
        'Index trace un cercle autour des lèvres.',
    synonyms: ['lèvres', 'langue'],
    usageExample: 'Ouvre la bouche.',
  ),
  SignModel(
    id: 'oreille',
    word: 'oreille',
    category: SignCategory.corps,
    emoji: '👂',
    description:
        'Index et pouce pincent légèrement le lobe de l\'oreille.',
    synonyms: ['ouïe', 'oreilles'],
    usageExample: 'J\'ai mal à l\'oreille.',
  ),
  SignModel(
    id: 'coeur',
    word: 'cœur',
    category: SignCategory.corps,
    emoji: '❤️',
    description:
        'Index et majeur des deux mains forment la forme d\'un cœur sur la poitrine, ou main à plat sur la poitrine.',
    synonyms: ['amour', 'cœur'],
    usageExample: 'Mon cœur bat vite.',
  ),

  // ─── TEMPS ───────────────────────────────────────────────────────────────────
  SignModel(
    id: 'aujourd_hui',
    word: "aujourd'hui",
    category: SignCategory.temps,
    emoji: '📅',
    description:
        'Les deux index pointent vers le bas (maintenant, ce jour-ci), en simultané.',
    synonyms: ['ce jour', 'maintenant', 'aujourd\'hui'],
    usageExample: "Aujourd'hui il fait beau.",
  ),
  SignModel(
    id: 'demain',
    word: 'demain',
    category: SignCategory.temps,
    emoji: '🌅',
    description:
        'Main droite à plat, paume vers la gauche, faire un arc vers l\'avant (le jour qui vient).',
    synonyms: ['le lendemain', 'après-demain'],
    usageExample: 'À demain !',
  ),
  SignModel(
    id: 'hier',
    word: 'hier',
    category: SignCategory.temps,
    emoji: '🌇',
    description:
        'Main droite à plat, faire un arc vers l\'arrière (le jour passé).',
    synonyms: ['avant-hier', 'la veille'],
    usageExample: "Hier j'étais malade.",
  ),
  SignModel(
    id: 'matin',
    word: 'matin',
    category: SignCategory.temps,
    emoji: '🌄',
    description:
        'Avant-bras gauche horizontal, main droite posée sur le coude gauche, relevée vers le haut (soleil qui se lève).',
    synonyms: ['matinée', 'le matin'],
    usageExample: 'Je me lève tôt le matin.',
  ),
  SignModel(
    id: 'soir',
    word: 'soir',
    category: SignCategory.temps,
    emoji: '🌆',
    description:
        'Avant-bras gauche horizontal, main droite posée dessus, abaissée vers le bas (soleil qui se couche).',
    synonyms: ['soirée', 'le soir', 'nuit'],
    usageExample: 'On se voit ce soir.',
  ),
  SignModel(
    id: 'maintenant',
    word: 'maintenant',
    category: SignCategory.temps,
    emoji: '⏱️',
    description:
        'Les deux mains à plat, paumes vers le haut, abaissées légèrement vers le bas (ici et maintenant).',
    synonyms: ['tout de suite', 'à présent', 'immédiatement'],
    usageExample: 'Viens maintenant.',
  ),
  SignModel(
    id: 'heure',
    word: 'heure',
    category: SignCategory.temps,
    emoji: '🕐',
    description:
        'Index de la main droite tapote le poignet gauche (là où se porte une montre).',
    synonyms: ['quelle heure', 'montre', 'temps'],
    usageExample: 'Quelle heure est-il ?',
  ),
  SignModel(
    id: 'semaine',
    word: 'semaine',
    category: SignCategory.temps,
    emoji: '🗓️',
    description:
        'Index tendu, balayage horizontal de gauche à droite (les 7 jours qui s\'enchaînent).',
    synonyms: ['la semaine', 'hebdomadaire'],
    usageExample: 'La semaine prochaine.',
  ),

  // ─── DIVERS (utile) ──────────────────────────────────────────────────────────
  SignModel(
    id: 'telephone',
    word: 'téléphone',
    category: SignCategory.divers,
    emoji: '📱',
    description:
        'Main en forme de Y (pouce et auriculaire tendus), portée à l\'oreille comme un téléphone.',
    synonyms: ['portable', 'appel', 'mobile'],
    usageExample: 'Donne-moi ton téléphone.',
  ),
  SignModel(
    id: 'argent',
    word: 'argent',
    category: SignCategory.divers,
    emoji: '💰',
    description:
        'Frapper le dos de la main gauche avec le dos de la main droite (repliée), geste de compter des billets.',
    synonyms: ['monnaie', 'euros', 'payer', 'prix'],
    usageExample: 'Tu as de l\'argent ?',
  ),
  SignModel(
    id: 'probleme',
    word: 'problème',
    category: SignCategory.divers,
    emoji: '❗',
    description:
        'Les deux index recourbés se cognent l\'un l\'autre par le dessus (obstacle qui se croise).',
    synonyms: ['souci', 'difficulté', 'ennui'],
    usageExample: 'Il y a un problème.',
  ),
  SignModel(
    id: 'question',
    word: 'question',
    category: SignCategory.divers,
    emoji: '❓',
    description:
        'Index trace un point d\'interrogation dans l\'air, ou main levée, paume vers l\'avant (interrogation).',
    synonyms: ['demander', 'interroger', 'pourquoi'],
    usageExample: 'J\'ai une question.',
  ),
  SignModel(
    id: 'voiture',
    word: 'voiture',
    category: SignCategory.divers,
    emoji: '🚗',
    description:
        'Les deux mains tiennent un volant imaginaire et tournent légèrement de gauche à droite.',
    synonyms: ['auto', 'automobile', 'conduire'],
    usageExample: 'Je prends la voiture.',
  ),
  SignModel(
    id: 'malade',
    word: 'malade',
    category: SignCategory.emotions,
    emoji: '🤒',
    description:
        'Index de la main droite touche le front, index de la main gauche touche l\'estomac simultanément (malaise général).',
    synonyms: ['maladie', 'souffrant', 'mal'],
    usageExample: 'Je suis malade aujourd\'hui.',
  ),
  SignModel(
    id: 'peur',
    word: 'peur',
    category: SignCategory.emotions,
    emoji: '😨',
    description:
        'Les deux mains ouvertes, doigts écartés, se rapprochent rapidement de la poitrine (sursaut de frayeur).',
    synonyms: ['crainte', 'effroi', 'avoir peur'],
    usageExample: 'J\'ai peur du noir.',
  ),
  SignModel(
    id: 'beau',
    word: 'beau',
    category: SignCategory.emotions,
    emoji: '😍',
    description:
        'Main ouverte devant le visage, faire un cercle de haut en bas (englober le beau visage/la belle chose).',
    synonyms: ['belle', 'joli', 'magnifique', 'superbe'],
    usageExample: 'C\'est beau.',
  ),
];

/// Accès par catégorie
Map<SignCategory, List<SignModel>> get kSignsByCategory {
  final map = <SignCategory, List<SignModel>>{};
  for (final sign in kSignsData) {
    map.putIfAbsent(sign.category, () => []).add(sign);
  }
  return map;
}

/// Alphabet manuel LSF — description de chaque lettre
const Map<String, String> kFingerAlphabet = {
  'A': 'Poing fermé, pouce sur le côté',
  'B': 'Main ouverte, doigts tendus et serrés, pouce plié',
  'C': 'Main en forme de C (demi-cercle)',
  'D': 'Index tendu, les autres doigts forment un cercle avec le pouce',
  'E': 'Doigts repliés, ongles touchant le pouce',
  'F': 'Pouce et index forment un cercle, autres doigts tendus',
  'G': 'Index et pouce parallèles, pointant sur le côté',
  'H': 'Index et majeur joints, pointant horizontalement',
  'I': 'Petit doigt levé, autres repliés',
  'J': 'Petit doigt levé, tracer un J dans l\'air',
  'K': 'Index et majeur en V, pouce entre les deux',
  'L': 'Index tendu vers le haut, pouce tendu sur le côté',
  'M': 'Trois doigts (index, majeur, annulaire) repliés sur le pouce',
  'N': 'Deux doigts (index, majeur) repliés sur le pouce',
  'O': 'Tous les doigts forment un cercle (forme de O)',
  'P': 'Comme K mais la main pointe vers le bas',
  'Q': 'Comme G mais la main pointe vers le bas',
  'R': 'Index et majeur croisés',
  'S': 'Poing fermé, pouce devant les doigts',
  'T': 'Pouce entre index et majeur',
  'U': 'Index et majeur tendus et joints',
  'V': 'Index et majeur tendus en V',
  'W': 'Index, majeur et annulaire tendus et écartés',
  'X': 'Index courbé en crochet',
  'Y': 'Pouce et petit doigt tendus (signe "appelle-moi")',
  'Z': 'Index trace un Z dans l\'air',
};

/// Emoji de l'alphabet manuel (simplifié)
const Map<String, String> kFingerAlphabetEmoji = {
  'A': '🅰️',
  'B': '🅱️',
  'C': '©️',
  'D': '✌️',
  'E': '✋',
  'F': '👌',
  'G': '👉',
  'H': '✌️',
  'I': '🤙',
  'J': '🤙',
  'K': '✌️',
  'L': '👆',
  'M': '✊',
  'N': '✊',
  'O': '👌',
  'P': '☝️',
  'Q': '☝️',
  'R': '🤞',
  'S': '✊',
  'T': '✊',
  'U': '✌️',
  'V': '✌️',
  'W': '🤟',
  'X': '☝️',
  'Y': '🤙',
  'Z': '☝️',
};
