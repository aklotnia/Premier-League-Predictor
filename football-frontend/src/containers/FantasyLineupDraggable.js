import React from 'react'
import FantasyTeamContainer from './FantasyTeamContainer'
import LineUpContainer from './LineUpContainer'
import PlayerObj from '../components/PlayerObj'
import { Droppable } from 'react-drag-and-drop'


class FantasyLineupSimulator extends React.Component {

    state = {

    }

    componentDidMount () {
        fetch('http://localhost:3000/players/liverpool')
        .then(resp => resp.json())
        .then(parsed => {this.setState({players: parsed})})
    }

    teamRender = () => {
        if (this.state.players) {
            return this.state.players.map((player) => {
                return <PlayerObj player={player} />
            }
            )
        }
    }

    onDrop(data) {
        console.log(data)
        // => banana 
    }

    render () {
        return(
            <div id="FantasyLineupSimulator">
                <div className="FantasyTeamContainer1">
                <h4>
                    Liverpool Players
                </h4>
                <div className="PlayerObjList">
                    {this.teamRender()}
                </div>
            </div>
                {/* <FantasyTeamContainer class="FantasyTeamContainer1" /> */}
                <div className="LineUpContainer" id="FantasyTeamContainer1">
                <img className="SoccerPitchTemplate" src="FootballPitch.png" alt="Soccer Pitch Template" />
                <div>

                </div>
                <Droppable types={['forward']} onDrop={this.onDrop.bind(this)}>
                <div className="ForwardArea">
                    j
                </div>
                </Droppable>
                <div className="MidfieldArea"> 
                    j
                </div>
                <div className="DefenseArea">
                    o
                </div>
                <div className="GoalkeepingArea">
                    z
                </div>
            </div>
                {/* <LineUpContainer id="LineUpContainer1" /> */}
                <LineUpContainer id="LineUpContainer2" />
                {/* <FantasyTeamContainer class="FantasyTeamContainer2" /> */}
            </div>
        )
    }
}

export default FantasyLineupSimulator