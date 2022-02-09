# Nashville Metro Traffic Accidents Analysis
This project's purpose is to do some data cleaning and data exploration of public records regarding car accidents for the year of 2021. The data set used for this project is the Traffic Accidents data set obtained from the Nashville Open Data Portal. A public data set containing accident reports by the Nashville Metro Police Department across the Nashville metropolitan area.

The cleaning that was done to the data set was the following:

    - Separation of the 'date_and_time' field into two separate fields for ease of use.
    - Drop the unnecessary data fields.
    - Correct the names in the 'precinct' field, since they are incompletely written.
    - Populate the 'propery_damage' field.

The SQL scripts used to perform all tasks in this project are included in this repository. After performing the data cleaning, some data exploration was performed. Some of the points analysed in this project were the following:
    
**1. Map breakdown of traffic accidents in 2021**

![accident_map](https://user-images.githubusercontent.com/82471196/153122970-c5d32cbf-bc60-449e-92dd-6298b6b63b11.png)

![Eight_Precinct_Map-1](https://user-images.githubusercontent.com/82471196/153123253-b31b3c0b-b01e-4848-888f-970c9a8a8854.png)
_- Police precinct map of Nashville Metro<sup>1</sup>_

The map shows the distribution of the accidents throughout the different police precincts in the Nashville metropolitan area. By comparing to the map of the police districts of Nashville metro, it becomes noticeable how the entire Nashville interstate system is very clearly displayed; and that the further it is from Downtown Nashville, the less common it is for accidents to be outside of a freeway. Intestate 40 is very clearly shown crossing through the west precinct and continuing onto Hermitage, as well as interstate 24 splitting Nashville diagonally.

Most of the accidents happen downtown and at the south of the city. __Over 60% of all reported traffic accidents in 2021 happen in the Hermitage, South, Midtown Hills, and Central precincts.__ With the exception of Madison, that is patrolled by the East precinct, four out of the five cities with the most accidents reported are patrolled by these precincts.

**2. Frequency of different accident types**

![accident_types](https://user-images.githubusercontent.com/82471196/153123637-bb71aaaa-23bc-4914-bc23-0f65379af3ed.png)

With more than 5,000 instances, **front to rear collisions (rear-ends) are the most common forms of traffic accidents**, closesly followed by angle collisions. Nashville drivers were also very propense to hit other objects that are not vehicles in 2021.

**3. Accidents per month**

![monthly_accidents](https://user-images.githubusercontent.com/82471196/153123680-095921c0-9f03-4e02-831d-2145383b6946.png)

**The month of October registered the highest number of accidents in 2021, while January registered the lowest.** The case of January was to be expected, since 2020 was a year of low movement due to the COVID-19 pandemic lockdown. October, however, is a different story. Having a lot more accident reports than the following months of November and December, considering that many people travel around to be with their families for Thanksgiving and Christmas, respectively. December and the summer month of June are interesting dips. **Excluding the low months of January and February, they June and December registered the least amounts of accidents.**

**4. Accidents and injuries**

![annual_accidents_injuries](https://user-images.githubusercontent.com/82471196/153123793-c7c087fe-defb-4b0e-8185-c6d3348c60ab.png)
_- Chart 1_

![accidents_injuries_2021](https://user-images.githubusercontent.com/82471196/153123802-ad526345-f6ab-4e67-af9d-68ccb5dbe03a.png)
_- Chart 2_

The complete data set contains data that dates back to 2015. For this point, previous years were also analysed. Chart 1 displays the distribution of accidents and injuries for different years. As expected, **the amount of accidents per year dramatically decreases for 2020 and 2021**, the years of the COVID-19 pandemic. Also, with the exception of 2021, **around 37% of all accidents involve injury**. Looking at Chart 2 it is noticeable that as 2021 progresses, injuries become more common. **Over 50% of the traffic accidents in Nashville metro involved some sort of injury in the second half of the year. Bumping up its injury average to 46%**

**Citations:**

- Dataset: https://data.nashville.gov/Police/Traffic-Accidents/6v6w-hpcw
- Nashville metro police precinct map: https://www.nashville.gov/departments/police/community-services/precincts
