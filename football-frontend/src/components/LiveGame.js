import React from 'react'

class LiveGame extends React.Component {
    render () {
        return(
        <span className="LiveFixture">
            {this.props.livegame.elapsed}'
            &nbsp;
            {/* <img className="LiveBarImg" src={this.props.livegame.flag} /> */}
            <img className="LiveBarImg" src={this.props.livegame.home_crest} alt={this.props.livegame.home_team}/>
            &nbsp;
            {this.props.livegame.home_team}
            &nbsp;
            {this.props.livegame.home_goals}
            -
            {this.props.livegame.away_goals}
            &nbsp;
            {this.props.livegame.away_team}
            &nbsp;
            <img className="LiveBarImg" src={this.props.livegame.away_crest} alt={this.props.livegame.away_team}/>
        </span>
        )
    }

}

export default LiveGame