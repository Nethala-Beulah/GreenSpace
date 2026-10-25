import '../models/plant.dart';

final List<Plant> initialCatalog = [
  const Plant(
    id: 'monstera',
    name: 'Monstera Deliciosa',
    scientificName: 'Monstera deliciosa',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=600',
    sunlight: 'Bright indirect light',
    watering: 'Every 7-10 days',
    wateringIntervalDays: 7,
    soil: 'Peat-based potting mix with perlite',
    difficulty: 'Easy',
    description:
        'Famous for its natural leaf-holes (fenestrations), the Swiss Cheese Plant is a showstopping tropical climber that thrives indoors with gentle warmth and humidity.',
    growthHabit: 'Climbing vine with aerial roots',
    isPetSafe: false,
    toxicityNotes:
        'Toxic to cats and dogs due to insoluble calcium oxalate crystals; can cause mouth irritation.',
    gardeningTip:
        'Gently wipe dust off the large leaves once a month to maximize photosynthesis.',
  ),
  const Plant(
    id: 'snake_plant',
    name: 'Snake Plant',
    scientificName: 'Sansevieria trifasciata',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1593482892290-f54927ae1bb6?w=600',
    sunlight: 'Low to bright indirect',
    watering: 'Every 14 days',
    wateringIntervalDays: 14,
    soil: 'Fast-draining cactus and succulent mix',
    difficulty: 'Easy',
    description:
        'An indestructible architectural houseplant with upright sword-like foliage. Excellent for bedrooms and low-light urban spaces.',
    growthHabit: 'Clumping upright foliage',
    isPetSafe: false,
    toxicityNotes:
        'Contains saponins which cause mild digestive distress in pets if chewed.',
    gardeningTip:
        'When in doubt, do not water. Snake plants prefer staying dry over wet roots.',
  ),
  const Plant(
    id: 'basil',
    name: 'Sweet Basil',
    scientificName: 'Ocimum basilicum',
    category: 'Herbs',
    imageUrl:
        'https://images.unsplash.com/photo-1618164436241-4473940d1f5c?w=600',
    sunlight: '6+ hours full sun',
    watering: 'Every 2-3 days',
    wateringIntervalDays: 2,
    soil: 'Rich, well-draining moist soil',
    difficulty: 'Easy',
    description:
        'A kitchen windowsill staple with aromatic tender leaves, perfect for fresh pesto, pasta, and herbal garnishes.',
    growthHabit: 'Bushy annual herb',
    isPetSafe: true,
    toxicityNotes: 'Non-toxic and pet-safe for both dogs and cats.',
    gardeningTip:
        'Pinch off the top flower buds to encourage dense bushy growth and sweeter leaves.',
  ),
  const Plant(
    id: 'lavender',
    name: 'English Lavender',
    scientificName: 'Lavandula angustifolia',
    category: 'Outdoor',
    imageUrl:
        'https://images.unsplash.com/photo-1499002238440-d264edd596ec?w=600',
    sunlight: 'Full direct sunlight',
    watering: 'Every 3-5 days',
    wateringIntervalDays: 4,
    soil: 'Sandy, alkaline, well-drained soil',
    difficulty: 'Moderate',
    description:
        'Renowned for its soothing fragrance, silvery-green foliage, and violet-blue floral spikes that attract pollinators to urban balconies.',
    growthHabit: 'Compact woody subshrub',
    isPetSafe: false,
    toxicityNotes:
        'Contains linalool and linalyl acetate; mildly toxic if ingested in large quantities by pets.',
    gardeningTip:
        'Ensure pots have ample drainage holes; lavender hates stagnant water around its roots.',
  ),
  const Plant(
    id: 'aloe_vera',
    name: 'Aloe Vera',
    scientificName: 'Aloe barbadensis miller',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=600',
    sunlight: 'Bright indirect to direct light',
    watering: 'Every 14-21 days',
    wateringIntervalDays: 14,
    soil: 'Gritty, porous cactus/succulent mix',
    difficulty: 'Easy',
    description:
        'A practical succulent with fleshy, gel-filled leaves treasured for soothing minor burns and moisturizing skin.',
    growthHabit: 'Stemless rosette succulent',
    isPetSafe: false,
    toxicityNotes:
        'Aloin in the outer leaf rind is toxic to animals; do not allow pets to chew.',
    gardeningTip:
        'Let the soil dry out completely between watering cycles, especially during cooler winter months.',
  ),
  const Plant(
    id: 'rosemary',
    name: 'Rosemary',
    scientificName: 'Salvia rosmarinus',
    category: 'Herbs',
    imageUrl:
        'https://images.unsplash.com/photo-1515586000433-45406d8e6662?w=600',
    sunlight: 'Full direct sunlight',
    watering: 'Every 5-7 days',
    wateringIntervalDays: 6,
    soil: 'Sandy, gritty, well-draining soil',
    difficulty: 'Moderate',
    description:
        'A hardy Mediterranean herb featuring pine-scented needle leaves, wonderful for culinary seasoning and aromatic garden borders.',
    growthHabit: 'Upright evergreen perennial shrub',
    isPetSafe: true,
    toxicityNotes: 'Non-toxic to pets according to the ASPCA.',
    gardeningTip:
        'Harvest sprigs in the morning when essential oils are at their highest concentration.',
  ),
  const Plant(
    id: 'boston_fern',
    name: 'Boston Fern',
    scientificName: 'Nephrolepis exaltata',
    category: 'Outdoor',
    imageUrl:
        'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=600',
    sunlight: 'Filtered light or partial shade',
    watering: 'Keep soil evenly moist (every 3 days)',
    wateringIntervalDays: 3,
    soil: 'Rich, loamy, moisture-retentive mix',
    difficulty: 'Moderate',
    description:
        'Features lush arching fronds with feathered green pinnae. An exceptional hanging plant that loves humid patio settings.',
    growthHabit: 'Arching frond cluster',
    isPetSafe: true,
    toxicityNotes: 'Completely pet-safe for dogs and cats.',
    gardeningTip:
        'Mist the fronds or place near a pebble tray to maintain humidity in dry indoor rooms.',
  ),
  const Plant(
    id: 'peace_lily',
    name: 'Peace Lily',
    scientificName: 'Spathiphyllum wallisii',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1593691509543-c55fb32e5cee?w=600',
    sunlight: 'Medium to low indirect light',
    watering: 'Every 5-7 days',
    wateringIntervalDays: 5,
    soil: 'Organic potting soil with perlite',
    difficulty: 'Easy',
    description:
        'Famous for its deep green glossy leaves and elegant white spathes. It gracefully signals thirst by gently drooping when ready for water.',
    growthHabit: 'Clump-forming evergreen perennial',
    isPetSafe: false,
    toxicityNotes:
        'Contains insoluble oxalates that can irritate lips and mouth if ingested by curious pets.',
    gardeningTip:
        'Water promptly when leaves begin a slight droop, and watch it perk up within hours.',
  ),
  const Plant(
    id: 'golden_pothos',
    name: 'Golden Pothos',
    scientificName: 'Epipremnum aureum',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1597055181300-e3633a917c9c?w=600',
    sunlight: 'Moderate to low indirect light',
    watering: 'Every 7-10 days',
    wateringIntervalDays: 7,
    soil: 'Standard indoor potting mix',
    difficulty: 'Easy',
    description:
        'Heart-shaped leaves variegated with streaks of gold and cream. Ideal for trailing down bookshelves or climbing moss poles.',
    growthHabit: 'Trailing or climbing tropical vine',
    isPetSafe: false,
    toxicityNotes:
        'Mildly toxic to pets if chewed; place high on shelves away from pets.',
    gardeningTip:
        'Propagates effortlessly in a glass of water from a single stem cutting with a node.',
  ),
  const Plant(
    id: 'spider_plant',
    name: 'Spider Plant',
    scientificName: 'Chlorophytum comosum',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1572688484437-31820e39ec14?w=600',
    sunlight: 'Bright indirect sunlight',
    watering: 'Every 6-8 days',
    wateringIntervalDays: 7,
    soil: 'Loose, well-draining potting soil',
    difficulty: 'Easy',
    description:
        'Ribbon-like green and white striped leaves that produce hanging runner stems adorned with delightful miniature "plantlets".',
    growthHabit: 'Arching rosette clumper',
    isPetSafe: true,
    toxicityNotes: '100% non-toxic and pet-safe for cats and dogs.',
    gardeningTip:
        'Snip off spiderettes when roots form and pot them directly into small containers for quick gifts.',
  ),
  const Plant(
    id: 'zz_plant',
    name: 'ZZ Plant',
    scientificName: 'Zamioculcas zamiifolia',
    category: 'Indoor',
    imageUrl:
        'https://images.unsplash.com/photo-1632207691143-643e2a9a9361?w=600',
    sunlight: 'Low to bright indirect',
    watering: 'Every 14-20 days',
    wateringIntervalDays: 14,
    soil: 'Well-draining potting soil with pumice',
    difficulty: 'Easy',
    description:
        'Boasts waxy, deep green leaves that reflect sunlight like polished lacquer. Underground rhizomes store moisture for extreme drought resistance.',
    growthHabit: 'Upright wand-like stems',
    isPetSafe: false,
    toxicityNotes:
        'Contains calcium oxalate crystals; wash hands after pruning sap.',
    gardeningTip:
        'Requires very little water; allow the potting mixture to dry out almost completely.',
  ),
  const Plant(
    id: 'fiddle_leaf_fig',
    name: 'Fiddle Leaf Fig',
    scientificName: 'Ficus lyrata',
    category: 'Indoor',
    imageUrl: 'https://images.unsplash.com/photo-1545241047-6083a3684587?w=600',
    sunlight: 'Consistent bright filtered light',
    watering: 'Every 7-10 days',
    wateringIntervalDays: 8,
    soil: 'Rich, aerated potting soil with bark',
    difficulty: 'Advanced',
    description:
        'A stately statement tree featuring dramatic violin-shaped leaves. Appreciates consistent indoor spots away from cold drafts.',
    growthHabit: 'Upright indoor tree',
    isPetSafe: false,
    toxicityNotes:
        'Milky sap can cause irritation to animal skin and stomachs.',
    gardeningTip:
        'Rotate the pot a quarter-turn each week so all sides receive balanced light exposure.',
  ),
];
