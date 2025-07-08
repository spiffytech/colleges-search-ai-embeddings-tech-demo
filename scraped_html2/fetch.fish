#!/usr/bin/env fish

set -l data \
    "College" "https://www.ncsu.edu/colleges-and-departments/?view=colleges" \
    "Alphabetical_List" "https://www.ncsu.edu/colleges-and-departments/?view=dept" \
    "College_of_Agriculture_and_Life_Sciences" "https://cals.ncsu.edu/" \
    "Agricultural_and_Human_Sciences" "https://cals.ncsu.edu/agricultural-and-human-sciences/" \
    "Agricultural_and_Resource_Economics" "https://cals.ncsu.edu/agricultural-and-resource-economics" \
    "Agricultural_Institute" "https://cals.ncsu.edu/agricultural-institute/" \
    "Animal_Science" "https://cals.ncsu.edu/animal-science" \
    "Applied_Ecology" "https://cals.ncsu.edu/applied-ecology" \
    "Biological_and_Agricultural_Engineering" "http://www.bae.ncsu.edu/" \
    "Crop_and_Soil_Sciences" "https://cals.ncsu.edu/crop-and-soil-sciences/" \
    "Entomology_and_Plant_Pathology" "https://cals.ncsu.edu/entomology-and-plant-pathology/" \
    "Food_Bioprocessing_and_Nutrition_Sciences" "https://fbns.ncsu.edu/" \
    "Horticultural_Science" "https://cals.ncsu.edu/horticultural-science" \
    "Molecular_and_Structural_Biochemistry" "https://cals.ncsu.edu/molecular-and-structural-biochemistry" \
    "Plant_and_Microbial_Biology" "https://cals.ncsu.edu/plant-and-microbial-biology" \
    "Prestage_Department_of_Poultry_Science" "https://cals.ncsu.edu/prestage-department-of-poultry-science" \
    "College_of_Design" "https://design.ncsu.edu/" \
    "Architecture" "https://design.ncsu.edu/architecture/" \
    "Graphic_Design" "https://design.ncsu.edu/graphic-design/" \
    "Industrial_Design" "https://design.ncsu.edu/industrial-design/" \
    "Landscape_Architecture_and_Environmental_Planning" "https://design.ncsu.edu/landscape-architecture/" \
    "Media_Arts_Design_and_Technology" "https://design.ncsu.edu/mad-tech/" \
    "College_of_Education" "https://ced.ncsu.edu/" \
    "Educational_Leadership_Policy_and_Human_Development" "http://ced.ncsu.edu/elphd/" \
    "Science_Technology_Engineering_Mathematics_Education" "http://ced.ncsu.edu/stem-ed/" \
    "Teacher_Education_and_Learning_Sciences" "http://ced.ncsu.edu/tels/" \
    "College_of_Engineering" "https://www.engr.ncsu.edu/" \
    "Biological_and_Agricultural_Engineering_2" "http://www.bae.ncsu.edu/" \
    "Biomedical_Engineering" "http://www.bme.ncsu.edu/" \
    "Chemical_and_Biomolecular_Engineering" "https://www.cbe.ncsu.edu/" \
    "Civil_Construction_and_Environmental_Engineering" "https://www.ccee.ncsu.edu/" \
    "Computer_Science" "https://www.csc.ncsu.edu/" \
    "Edward_P_Fitts_Department_of_Industrial_Systems_Engineering" "http://www.ise.ncsu.edu/" \
    "Electrical_and_Computer_Engineering" "http://www.ece.ncsu.edu/" \
    "Materials_Science_and_Engineering" "http://www.mse.ncsu.edu/" \
    "Mechanical_and_Aerospace_Engineering" "http://www.mae.ncsu.edu/" \
    "Nuclear_Engineering" "http://www.ne.ncsu.edu/" \
    "College_of_Humanities_and_Social_Sciences" "https://chass.ncsu.edu/" \
    "Communication" "http://communication.chass.ncsu.edu/" \
    "English" "http://english.chass.ncsu.edu/" \
    "History" "http://history.chass.ncsu.edu/" \
    "Interdisciplinary_Studies" "http://ids.chass.ncsu.edu/" \
    "Philosophy_and_Religious_Studies" "https://philrel.chass.ncsu.edu/" \
    "Political_Science_in_the_School_of_Public_and_International_Affairs" "http://spia.ncsu.edu/ps/index.html" \
    "Psychology" "http://psychology.chass.ncsu.edu/" \
    "Public_Administration_in_the_School_of_Public_and_International_Affairs" "http://spia.ncsu.edu/pa/" \
    "Social_Work" "http://socialwork.chass.ncsu.edu/" \
    "Sociology_and_Anthropology" "http://socant.chass.ncsu.edu/" \
    "World_Languages_and_Cultures" "https://wlc.chass.ncsu.edu/" \
    "College_of_Natural_Resources" "https://cnr.ncsu.edu/" \
    "Forest_Biomaterials" "http://cnr.ncsu.edu/fb/" \
    "Forestry_and_Environmental_Resources" "http://cnr.ncsu.edu/fer" \
    "Parks_Recreation_and_Tourism_Management" "http://cnr.ncsu.edu/prtm" \
    "Poole_College_of_Management" "https://poole.ncsu.edu/" \
    "Accounting" "https://poole.ncsu.edu/accounting/" \
    "Business_Management" "https://poole.ncsu.edu/business-management/" \
    "Economics" "https://poole.ncsu.edu/economics/" \
    "Management_Innovation_and_Entrepreneurship" "https://poole.ncsu.edu/mie/" \
    "College_of_Sciences" "https://sciences.ncsu.edu/" \
    "Biological_Sciences" "https://bio.sciences.ncsu.edu/" \
    "Chemistry" "https://chemistry.sciences.ncsu.edu/" \
    "Marine_Earth_and_Atmospheric_Sciences" "https://meas.sciences.ncsu.edu/" \
    "Mathematics" "https://math.sciences.ncsu.edu/" \
    "Physics" "http://www.physics.ncsu.edu/" \
    "Statistics" "https://statistics.sciences.ncsu.edu/" \
    "Wilson_College_of_Textiles" "https://textiles.ncsu.edu/" \
    "Textile_and_Apparel_Technology_and_Management" "https://textiles.ncsu.edu/tatm/" \
    "Textile_Engineering_Chemistry_and_Science" "https://textiles.ncsu.edu/tecs/" \
    "College_of_Veterinary_Medicine" "https://cvm.ncsu.edu/" \
    "Clinical_Sciences" "https://cvm.ncsu.edu/research/departments/docs/" \
    "Molecular_Biomedical_Sciences" "https://cvm.ncsu.edu/research/departments/mbs/" \
    "Population_Health_and_Pathobiology" "https://cvm.ncsu.edu/research/departments/dphp/" \
    "Graduate_School" "https://grad.ncsu.edu/" \
    "Advanced_Analytics" "http://analytics.ncsu.edu/" \
    "University_College" "https://universitycollege.dasa.ncsu.edu/" \
    "Air_Force_ROTC" "http://airforce.dasa.ncsu.edu/" \
    "Army_ROTC" "http://army.dasa.ncsu.edu/" \
    "Dance_Program" "https://dance.arts.ncsu.edu/" \
    "Exploratory_Studies" "https://advising.dasa.ncsu.edu/welcome-to-exploratory-studies/" \
    "Health_and_Exercise_Studies" "http://hes.dasa.ncsu.edu/" \
    "Music" "https://music.dasa.ncsu.edu/" \
    "Naval_ROTC" "http://naval.dasa.ncsu.edu/" \
    "Theatre" "https://theatre.arts.ncsu.edu/"

for i in (seq 1 2 (count $data))
    set filename $data[$i].html
    set url $data[(math $i + 1)]
    curl -L -o $filename $url
    echo "Downloaded: $filename"
end

