import React from 'react'
import UpcomingFixturesAllContainer from './UpcomingFixturesAllContainer'

class UpcomingFixturesAll extends React.Component {
    render() {
        return(
            <div id="UpcomingFixturesAll">
                <div id="UpcomingFixtureAllTableTransient">j</div>
                <div id="UpcomingFixturesAllHeader"><strong id="UpcomingFixturesAllText">Upcoming Fixtures<br></br> 2019/2020 </strong></div>
                <UpcomingFixturesAllContainer home={this.props.home} />
            </div>
        )
    }
}

export default UpcomingFixturesAll