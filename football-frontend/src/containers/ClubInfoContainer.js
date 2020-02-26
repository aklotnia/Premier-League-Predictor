import React from 'react'

class ClubInfoContainer extends React.Component {

    infoRenderer = () => {
        if (this.props.clubinfo) {
            return(
                <div className="ClubInfoContainer">
                    <img className="ClubInfoCrest" src={this.props.clubinfo.logo} alt={this.props.clubinfo.name}/>
                    <div className="ClubInfoCell">
                        <h1 id="ClubName">{this.props.clubinfo.name}</h1>
                        <div id="ClubInfoInternal">
                            <div id="ClubCountry"><br></br>Country: <br/> {this.props.clubinfo.country} <img id="EnglandFlag" src="england.png" alt="England Flag"/></div>
                            <div id="ClubFounded">Year Founded: {this.props.clubinfo.founded}</div>
                            <div id="ClubCity">City: {this.props.clubinfo.venue_city}</div>
                            <div id="ClubStadium">
                                <br></br>
                                Stadium: {this.props.clubinfo.stadium_name}<br/>
                                Capacity: {this.props.clubinfo.venue_capacity}<br/>
                            </div>
                        </div>
                        <div id="Description"></div>
                        
                    </div>
                </div>
            )
        }
    }
    render() {
        return(
            <div id="ClubInfo">
                {this.infoRenderer()}
                <div id="PremierLeagueCrowdTransient"></div>
                <img id="PremierLeagueCrowd" src="https://img.wallpapersafari.com/desktop/1920/1080/43/53/vsk4GN.jpg" alt="Premier League Fans"/>
            </div>
        )
    }
}

export default ClubInfoContainer