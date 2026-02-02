extends Node

func get_words_for_difficulty(difficulty: int = 1) -> Array[String]:
	if difficulty == 1:
		return _collect_words(size_4)
	elif difficulty == 2:
		return _collect_words(size_5)
	elif difficulty == 3:
		return _collect_words(size_6)
	elif difficulty == 4:
		return _collect_words(size_7)
	elif difficulty == 5:
		return _collect_words(size_8)
	elif difficulty == 6:
		return _collect_words(size_9)
	elif difficulty == 7:
		return _collect_words(size_10)
	elif difficulty == 8:
		return _collect_words(size_11)
	elif difficulty == 9:
		return _collect_words(size_12)
	else:
		return _collect_words(size_12)
			

func _collect_words(arr: Array) -> Array[String]:
	var result: Array[String] = []
	for a in arr:
		if "word" in a:
			result.append(a["word"])
	return result


func get_unique_sorted_letters(text: String) -> Array:
	var result_dict := {}
	var lowerletters_regex := RegEx.new()
	lowerletters_regex.compile("[a-z]")

	
	for l in text.to_lower():
		if lowerletters_regex.search(l):
			result_dict[l] = true
	var result := result_dict.keys()
	result.sort()
	return result


# I collected country names from https://random-words-api.kushcreates.com/
# with the query https://random-words-api.kushcreates.com/api?language=en&category=countries&length=7&type=capitalized 
# See https://random-words-api.kushcreates.com/ for a UI

var size_4 = [
  {
	"word": "Chad",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Cuba",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Fiji",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Iran",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Iraq",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mali",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Oman",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Peru",
	"length": 4,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Togo",
	"length": 4,
	"category": "countries",
	"language": "en"
  }
]

var size_5 = [
  {
	"word": "Benin",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Chile",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "China",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Congo",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Egypt",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Gabon",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Ghana",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Haiti",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "India",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Italy",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Japan",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Kenya",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Libya",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Malta",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Nauru",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Nepal",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Niger",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Palau",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Qatar",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Samoa",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Spain",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Sudan",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Tonga",
	"length": 5,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Yemen",
	"length": 5,
	"category": "countries",
	"language": "en"
  }
]

var size_6 = [
  {
	"word": "Angola",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Belize",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bhutan",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Brazil",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Canada",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Cyprus",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "France",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Gambia",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Greece",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Guinea",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Guyana",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Israel",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Jordan",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Kuwait",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Latvia",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Malawi",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mexico",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Monaco",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Norway",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Panama",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Poland",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Rwanda",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Serbia",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Sweden",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Tuvalu",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Uganda",
	"length": 6,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Zambia",
	"length": 6,
	"category": "countries",
	"language": "en"
  }
]

var size_7 = [
  {
	"word": "Albania",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Algeria",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Andorra",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Armenia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Austria",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bahamas",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bahrain",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Belarus",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Belgium",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bolivia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Burundi",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Comoros",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Croatia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Czechia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Denmark",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Ecuador",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Eritrea",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Estonia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Finland",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Georgia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Germany",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Grenada",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Hungary",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Iceland",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Ireland",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Jamaica",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Lebanon",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Lesotho",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Liberia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Morocco",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Myanmar",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Namibia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Nigeria",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Romania",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Senegal",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Somalia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Tunisia",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Ukraine",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Uruguay",
	"length": 7,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Vanuatu",
	"length": 7,
	"category": "countries",
	"language": "en"
  }
]

var size_8 = [
  {
	"word": "Barbados",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Botswana",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bulgaria",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Cambodia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Cameroon",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Colombia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Djibouti",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Dominica",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Eswatini",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Ethiopia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Honduras",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Kiribati",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Malaysia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Maldives",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mongolia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Pakistan",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Paraguay",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Portugal",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Slovakia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Slovenia",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Suriname",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Thailand",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Türkiye",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Viet nam",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Zimbabwe",
	"length": 8,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Holy see",
	"length": 8,
	"category": "countries",
	"language": "en"
  }
]

var size_9 = [
  {
	"word": "Argentina",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Australia",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Guatemala",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Indonesia",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Lithuania",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mauritius",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Nicaragua",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Palestine",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Singapore",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Sri lanka",
	"length": 9,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Venezuela",
	"length": 9,
	"category": "countries",
	"language": "en"
  }
]

var size_10 = [
  {
	"word": "Azerbaijan",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Bangladesh",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Cabo verde",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Costa rica",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Kazakhstan",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Kyrgyzstan",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Luxembourg",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Madagascar",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mauritania",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Micronesia",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Montenegro",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Mozambique",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "San marino",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Seychelles",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Tajikistan",
	"length": 10,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Uzbekistan",
	"length": 10,
	"category": "countries",
	"language": "en"
  }
]

var size_11 = [
  {
	"word": "Afghanistan",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "El salvador",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Netherlands",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "New zealand",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Philippines",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Saint lucia",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "South sudan",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Switzerland",
	"length": 11,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Timor-leste",
	"length": 11,
	"category": "countries",
	"language": "en"
  }
]

var size_12 = [
  {
	"word": "Burkina faso",
	"length": 12,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Saudi arabia",
	"length": 12,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Sierra leone",
	"length": 12,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "South africa",
	"length": 12,
	"category": "countries",
	"language": "en"
  },
  {
	"word": "Turkmenistan",
	"length": 12,
	"category": "countries",
	"language": "en"
  }
]
