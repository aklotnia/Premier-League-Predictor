import React from 'react'
import ProbableOutcome from '../components/ProbableOutcome'
import FantasyLineupSimulator from './FantasyLineupSimulator'
// import FantasyLineupDraggable from './FantasyLineupDraggable'

class StatContainer extends React.Component {

    state = {
        home_team: this.props.home_team,
        away_team: this.props.away_team
    }

    componentDidMount () {
        fetch(`http://localhost:3000/games/nn/${this.props.home_team}/${this.props.away_team}`)
        .then(resp => resp.json())
        .then(parsed => {this.setState({neural_network_prediction: parsed})})
    }

    componentDidUpdate () {
        if (this.props.home_team !== this.state.home_team || this.props.away_team !== this.state.away_team) {
            fetch(`http://localhost:3000/games/nn/${this.props.home_team}/${this.props.away_team}`)
            .then(resp => resp.json())
            .then(parsed => {this.setState({neural_network_prediction: parsed, home_team: this.props.home_team, away_team: this.props.away_team})})
        }
    }

    render() {
        return(
            <div className="StatContainer">
                <div id="StatTitle">
                    <strong>{`${this.state.home_team} Vs. ${this.state.away_team}`}</strong>
                    {this.state.neural_network_prediction? <p>Neural Network Prediction: {this.state.neural_network_prediction.result}, CF: {Math.round(this.state.neural_network_prediction.confidence)}%</p> : null}
                </div>
                 <ProbableOutcome home_team={this.state.home_team} away_team={this.state.away_team}/>
                 <FantasyLineupSimulator />
                 <div id="Spacer"></div>
            </div>
        )
    }
}

export default StatContainer