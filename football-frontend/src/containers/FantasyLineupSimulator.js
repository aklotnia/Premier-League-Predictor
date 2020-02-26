import React from 'react'
import FantasyTeamContainer from './FantasyTeamContainer'
import LineUpContainer from './LineUpContainer'

class FantasyLineupSimulator extends React.Component {

    state = {
        home_team: {"f": [], "m": [], "d": [], "g": null},
        away_team: {"f": [], "m": [], "d": [], "g": null},
        result: null
    }

    homeAddPlayer = (player_name, position) => {
        this.switchHelper(player_name, position, "home_team")
    }

    awayAddPlayer = (player_name, position) => {
        this.switchHelper(player_name, position, "away_team")
    }

    stateCalculator = () => {
        let homeGoalie = this.state.home_team.g? 1 : 0
        let awayGoalie = this.state.away_team.g? 1 : 0
        return this.state.home_team.f.length + this.state.home_team.m.length + this.state.home_team.d.length + homeGoalie + this.state.away_team.f.length + this.state.away_team.m.length + this.state.away_team.d.length + awayGoalie
    }

    simulate = () => {
        if (this.stateCalculator() === 22) {
        fetch('http://localhost:3000/games/simulate', {
            method: "POST",
            headers: {
                'Accept': "application/json",
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                state: this.state
            })
        })
        .then(resp => resp.json())
        .then(parsed => {this.setState({
            result: parsed, home_team: {"f": [], "m": [], "d": [], "g": null}, 
            away_team: {"f": [], "m": [], "d": [], "g": null}})})

        let images = document.querySelectorAll('.GameImage')
        images.forEach((image) => {
            image.src = "https://resources.premierleague.com/premierleague/photos/players/110x140/Photo-Missing.png"
            image.alt = "Template Silouhette"
        })
        } else {
            alert("Please Fill Both Teams")
        }
    }

    switchHelper = (player_name, position, target) => {
        switch (position) {
            case "f":
                this.setState({[`${target}`]: {"f": [...this.state[`${target}`]["f"], player_name], "m": this.state[`${target}`].m,"d": this.state[`${target}`].d, "g": this.state[`${target}`].g}})
                break;

            case "m":
                this.setState({[`${target}`]: {"f": this.state[`${target}`]["f"], "m": [...this.state[`${target}`].m, player_name],"d": this.state[`${target}`].d, "g": this.state[`${target}`].g}})
                break;
        
            case "d":
                this.setState({[`${target}`]: {"f": this.state[`${target}`]["f"], "m": this.state[`${target}`].m,"d": [...this.state[`${target}`].d, player_name], "g": this.state[`${target}`].g}})
                break;

            case "g":
                this.setState({[`${target}`]: {"f": this.state[`${target}`]["f"], "m": this.state[`${target}`].m,"d": this.state[`${target}`].d, "g": player_name}})
                break;
        
            default:
                break;
        }
    }

    render () {
        return(
            <div id="FantasyLineupSimulatorContainer">
                <h1>Match Simulator Measuring Player Impact</h1>
                {this.state.result? <h3>{this.state.result}!</h3> : <h3>Drag Player Images from their Respective Team Containers onto Empty Player Portraits to Fill Teams and then Click Simulate!</h3>}
                <div id="FantasyLineupSimulator">
                    <FantasyTeamContainer class="FantasyTeamContainer1" team="liverpool" obj = {this.state.home_team}/>
                    <LineUpContainer id="LineUpContainer1" team="Liverpool" homeAddPlayer={this.homeAddPlayer} />
                    <LineUpContainer id="LineUpContainer2" team="Tottenham" awayAddPlayer={this.awayAddPlayer} />
                    <FantasyTeamContainer class="FantasyTeamContainer2" team="tottenham" obj = {this.state.away_team}/>
                </div>
                <button id="SimulateButton" onClick={this.simulate}>Simulate</button>
            </div>
        )
    }
}

export default FantasyLineupSimulator