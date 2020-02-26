import React from 'react'
import LeagueTable from './LeagueTable'
import UpcomingFixturesAll from './UpcomingFixturesAll'
import NewsContainer from './NewsContainer'
import NewsHeader from '../components/NewsHeader'

class HomePage extends React.Component {
    

    render() {
        return(
            <div id="HomePage">
                <div ><img id="EPLPicture" src={'http://getwallpapers.com/wallpaper/full/d/d/b/762333-free-download-premier-league-wallpapers-2560x1440.jpg'} alt="EPL Screensaver Splash"/></div>
                <div id="HomeGradient"></div>
                <div id="HomePageColumn1">
                    <LeagueTable />
                    <UpcomingFixturesAll home={this.props.home} />
                </div>
                <div id="HomePageColumn2">
                    <NewsHeader />
                    <NewsContainer />
                </div>
            </div>
        )
    }
}

export default HomePage