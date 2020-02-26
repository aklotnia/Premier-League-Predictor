import React from 'react'
import TeamStanding from '../components/TeamStanding'

class LeagueStandingsContainer extends React.Component {

    state = {

    }

    componentDidMount () {
        fetch('http://localhost:3000/standings')
        .then(resp => resp.json())
        .then(parsed => this.setState({standings: parsed}))
    }
//     crest
// "http://upload.wikimedia.org/wikipedia/de/0/0a/FC_Liverpool.svg"
// drawn_games
// 1
// goal_difference
// 41
// goals_against
// 15
// goals_for
// 56
// id
// 21
// lost_games
// 0
// name
// "Liverpool FC"
// played_games
// 24
// points
// 70
// position
// "1"
// won_games
// 23

    standingRenderer = () => {
        if (this.state.standings) {
            return this.state.standings.map((team) => {
                let keyid = Math.random()
                return <TeamStanding key={keyid} team={team} />
            })
        }
    }



    render() {
        return (
            <div id="LeagueStandingsContainer" >
                <table cellspacing="0" cellPadding="4">
                    <thead>
                        <tr className="TableHeader">
                            <th>Pos</th>
                            <th></th>
                            <th id="Wide">Club</th>
                            <th>Pts</th>
                            <th>W</th>
                            <th>D</th>
                            <th>L</th>
                            <th>GF</th>
                            <th>GA</th>
                            <th>GD</th>
                            <th>MP</th>
                        </tr>
                    </thead>
                    <tbody id="StandingBody">
                        {this.standingRenderer()}
                    </tbody>
                </table>
            </div>
        )
    }
}

export default LeagueStandingsContainer